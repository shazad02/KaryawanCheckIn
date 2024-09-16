import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile2karyawan/navigator/navigator_screen.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/widget/custom_textfiled.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool isLoading = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        // Memeriksa apakah email tersedia dalam koleksi "user"
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.size > 0) {
          // Email tersedia, lanjutkan proses login
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          print(userCredential.user!.uid);
          // Login berhasil, lanjutkan ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorScreen(),
            ),
          );
        } else {
          // Email tidak ditemukan dalam koleksi "user"
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Email Tidak Terdaftar'),
              content: const Text('Email yang Anda masukkan Sudah DI Banned.'),
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
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Salah'),
              content: const Text('Password Salah Coba lagi'),
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
              title: const Text('Password Gagal'),
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

  Widget _textfiledemail() {
    return Column(
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
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return "Please enter a valid email address";
            }
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
    );
  }

  Widget _textfiledpassword() {
    return Column(
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
    );
  }

  Widget _buttonLogin() {
    return MultiBottom(
        textButton: "LOGIN",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 8 / 100,
                    ),
                    Image.asset(
                      Images.logo1,
                      width: MediaQuery.of(context).size.height * 10 / 100,
                    ),
                  ],
                ),
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
                _textfiledemail(),
                _textfiledpassword(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 6 / 100,
                ),
                Center(child: _buttonLogin())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
