import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile2karyawan/navigator/navigator_screen.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/widget/custom_textfiled.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _RegisterScreenState extends State<RegisterScreen> {
  late String email;
  late String name;
  late String phone;
  late String password;
  bool? isLoading = false;
  bool? isChecked = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // ignore: unused_local_variable
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('user').doc(userCredential.user!.uid).set({
          "name": name,
          "email": email,
          "phone": phone,
          "userid": userCredential.user!.uid,
        });
        print(userCredential.user!.uid);
        // Login berhasil, lanjutkan ke halaman berikutnya
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigatorScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'email-already-in-use') {
          // Email address is already in use
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'The email address is already in use by another account.'),
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
        } else {
          // Other FirebaseAuthException occurred
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

  Widget _textfiledname() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nama Lengkap",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          CustomTextFil(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama is required';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
        ],
      ),
    );
  }

  Widget _textfilednomer() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nomer Telepon",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          CustomTextFil(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'Nomer is required';
              } else if (value.length < 11) {
                return 'Nomer Terlalu Pendek';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
        ],
      ),
    );
  }

  Widget _textfiledemail() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          CustomTextFil(
            validate: (value) {
              // Check if this field is empty
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }

              // using regular expression
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Please enter a valid email address";
              }

              // the email is valid
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
        ],
      ),
    );
  }

  Widget _textfiledpassword() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          CustomTextFil(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
        ],
      ),
    );
  }

  Widget _buttondaftar() {
    return MultiBottom(
        textButton: "Daftar",
        onPressed: validation,
        buttomcolor: bg1Color,
        textcolor: bg4color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 5 / 100,
              right: MediaQuery.of(context).size.width * 5 / 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Silahkan daftar terlebih dahulu",
                  style: TextStyle(
                    color: bg1Color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                const Text(
                  "Silakan login atau daftarkan diri Anda sebelum menggunakan aplikasi ini.",
                  style: TextStyle(
                      color: bg2Color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                _textfiledname(),
                _textfilednomer(),
                _textfiledemail(),
                _textfiledpassword(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 15 / 100,
            vertical: MediaQuery.of(context).size.width * 5 / 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bg2Color,
          ),
          child: _buttondaftar(),
        ),
      ),
    );
  }
}
