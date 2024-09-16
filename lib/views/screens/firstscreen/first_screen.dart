import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/views/screens/loginscreen/login_screen.dart';
import 'package:mobile2karyawan/views/screens/registerscreen/register_screen.dart';
import 'package:mobile2karyawan/widget/button_custom.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Widget _buttonCustomLogin() {
    return ButtonCus(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      textButton: 'LOGIN',
      buttomcolor: bg1Color,
      textcolor: bg4color,
    );
  }

  Widget _buttonCustomDaftar() {
    return ButtonCus(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
      textButton: 'DAFTAR',
      buttomcolor: bg4color,
      textcolor: bg1Color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Center(
              child: Image.asset(
                Images.logo,
                width: MediaQuery.of(context).size.height * 10 / 100,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 7 / 100,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 3 / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat Datang di Techno Id",
                    style: TextStyle(
                        color: bg1Color,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 8 / 100,
                  ),
                  const Text(
                    "Silakan login atau daftarkan diri Anda sebelum menggunakan aplikasi ini.",
                    style: TextStyle(
                        color: bg2Color,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buttonCustomDaftar(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    _buttonCustomLogin(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
