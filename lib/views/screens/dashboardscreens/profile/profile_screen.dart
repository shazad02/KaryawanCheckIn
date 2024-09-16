import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/views/screens/firstscreen/first_screen.dart';
import 'package:mobile2karyawan/views/screens/spaslashscreen/spalsh_screen.dart';
import 'package:mobile2karyawan/widget/custom_textfiled.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _textfilednama() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nama Lengkap",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        CustomTextFil(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
      ],
    );
  }

  Widget _textfiledNip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "NIP",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        CustomTextFil(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
      ],
    );
  }

  Widget _textfiledNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nomer Telepon",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        CustomTextFil(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
      ],
    );
  }

  Widget _textfiledEmail() {
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
        CustomTextFil(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
      ],
    );
  }

  Widget _buttonsimpan() {
    return MultiBottom(
        textButton: "Simpan",
        onPressed: _logout,
        buttomcolor: bg1Color,
        textcolor: bg4color);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg1Color,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _logout,
              child: const Icon(
                Icons.logout,
                size: 35,
                color: bg3Color,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 25 / 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: bg1Color,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: bg4color,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image.asset(
                            Images.orang,
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const Icon(
                          Icons.edit,
                          color: bg4color,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 6 / 100),
              child: Column(
                children: [
                  _textfilednama(),
                  _textfiledNip(),
                  _textfiledNo(),
                  _textfiledEmail(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  _buttonsimpan(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
