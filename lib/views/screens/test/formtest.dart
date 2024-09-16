import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile2karyawan/navigator/navigator_screen.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/widget/custom_textfiled.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';

class FormAbsen extends StatefulWidget {
  const FormAbsen({Key? key}) : super(key: key);

  @override
  State<FormAbsen> createState() => _FormAbsenState();
}

class _FormAbsenState extends State<FormAbsen> {
  final TextEditingController keteranganControler = TextEditingController();

  Uint8List? _image;
  final bool _uploading =
      false; // Flag to indicate if image upload is in progress
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();

  int? selectedRadio;

  void _submitData(BuildContext context) async {
    String keterangan = keteranganControler.text.trim();

    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        'keterangan': keterangan,
      });

      // Setelah data berhasil dikirim, kosongkan semua field
      keteranganControler.clear();

      // Tampilkan pesan berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dikirim')),
      );

      // Pindah ke halaman NavigatorScreen setelah data berhasil dikirim
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigatorScreen(),
        ),
      );
    } catch (e) {
      // Jika terjadi error, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi')),
      );
    }
  }

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
      longitudeController.text = position.longitude.toString();
      latitudeController.text = position.latitude.toString();
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

  Widget _textKetertangan() {
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
            controller: keteranganControler,
            maxLines:
                null, // Atur menjadi null agar dapat menambahkan baris baru saat di enter
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
        onPressed: () => _submitData(context),
        buttomcolor: bg1Color,
        textcolor: bg4color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                              height:
                                  MediaQuery.of(context).size.height * 25 / 100,
                              width:
                                  MediaQuery.of(context).size.height * 20 / 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
                              height:
                                  MediaQuery.of(context).size.height * 25 / 100,
                              width:
                                  MediaQuery.of(context).size.height * 20 / 100,
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
              TextField(
                controller: longitudeController,
                readOnly: true,
                enabled: true,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: latitudeController,
                readOnly: true,
                enabled: true,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
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
              _textKetertangan(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              Center(child: _buttonsave()),
            ],
          ),
        ),
      ),
    );
  }
}
