import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile2karyawan/navigator/navigator_screen.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FormAbsen extends StatefulWidget {
  const FormAbsen({Key? key}) : super(key: key);

  @override
  State<FormAbsen> createState() => _FormAbsenState();
}

class _FormAbsenState extends State<FormAbsen> {
  late String? longti;
  late String? latit;
  late String keterangan;

  late String time;
  late String userId;
  String userName = '';
  bool? isLoading = false;
  late String jenis = '';

  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();

  Uint8List? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  int? selectedRadio;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
    selectedRadio = 0;
  }

  setSelectedRadio(int? val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void _getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle jika pengguna menolak memberikan izin lokasi
        // Contoh: menampilkan dialog atau memberikan pesan kepada pengguna
      }
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      longti = position.longitude.toString();
      latit = position.latitude.toString();
    });
  }

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null; // Return null if image selection is canceled or encounters an error
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null; // Return null if image capture is canceled or encounters an error
  }

  void getUserAddress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      setState(() {
        userName = userSnapshot['name'];
      });
    }
  }

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String imageUrl = await uploadImage('buktiImage', _image!, fileName);

        // Mengisi variabel yang dibutuhkan
        longti = longti;
        latit = latit;
        time = DateTime.now().toString();
        keterangan = keterangan;
        userId = FirebaseAuth.instance.currentUser!.uid;

        // Menentukan nilai jenis sesuai dengan radio button yang dipilih
        if (selectedRadio == 1) {
          jenis = 'Hadir';
        } else if (selectedRadio == 2) {
          jenis = 'Sakit';
        } else if (selectedRadio == 3) {
          jenis = 'Izin';
        }

        // Menyimpan data ke Firestore
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('absen').doc().set({
          "imageLink": imageUrl,
          "longti": longti,
          "latit": latit,
          "time": time,
          "keterangan": keterangan,
          "jenis": jenis, // Menggunakan nilai jenis yang sudah ditentukan
          "userId": userId,
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigatorScreen(),
          ),
        );
      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
        // Other PlatformException occurred
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.message ?? 'An error occurred.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      print("No");
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Kamera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textketerangan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Keterangan",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                keterangan = value;
              });
            },
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Masukkan keterangan...',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _buttonsave() {
    return MultiBottom(
        textButton: "Save Absen",
        onPressed: validation,
        buttomcolor: bg1Color,
        textcolor: bg4color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Rekap Absensi    ",
                  style: TextStyle(
                    color: bg1Color,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    25 /
                                    100,
                                width: MediaQuery.of(context).size.height *
                                    20 /
                                    100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImage,
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    25 /
                                    100,
                                width: MediaQuery.of(context).size.height *
                                    20 /
                                    100,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Image.asset(
                                  Images.foto,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Longitude"),
                    TextField(
                      controller: longitudeController,
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Lokasi Tersimpan",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          longti = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Latitude"),
                    TextField(
                      controller: latitudeController,
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Lokasi Tersimpan",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          latit = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _getCurrentLocation,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: bg3Color,
                      backgroundColor: bg1Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // radius tombol
                      ),
                    ),
                    child: const Text('Get Location'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val);
                          },
                        ),
                        const Text(
                          'Hadir',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val);
                          },
                        ),
                        const Text(
                          'Sakit',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val);
                          },
                        ),
                        const Text(
                          'Izin',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                _textketerangan(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Center(child: _buttonsave()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage(
      String childName, Uint8List file, String fileName) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(childName)
        .child(fileName); // Use fileName as the file name
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
