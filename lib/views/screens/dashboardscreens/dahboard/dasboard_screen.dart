import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/dahboard/component/jadwal.dart';

class DasboardScreen extends StatefulWidget {
  const DasboardScreen({super.key});

  @override
  State<DasboardScreen> createState() => _DasboardScreenState();
}

class _DasboardScreenState extends State<DasboardScreen> {
  bool value = false;

  Widget _jadwal1() {
    return const Jadwal(
      kegiatan: 'Analisis Sistem',
      jam: '23:45',
      tanggal: '7 Nov',
    );
  }

  Widget _jadwal2() {
    return const Jadwal(
      kegiatan: 'Analisis Sistem',
      jam: '20:30',
      tanggal: '4 Sept',
    );
  }

  Widget _jadwal3() {
    return const Jadwal(
      kegiatan: 'Analisis Sistem',
      jam: '12:00',
      tanggal: '1 Jul',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beranda",
          style: TextStyle(
            color: bg1Color,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 2 / 100),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 10 / 100,
              decoration: BoxDecoration(
                color: bg1Color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  CircleAvatar(
                    radius: 33,
                    child: Image.asset(
                      Images.orang,
                      width: 70,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Lengkap",
                        style: TextStyle(
                            color: bg4color,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "NIP",
                        style: TextStyle(
                            color: bg4color,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            color: bg4color,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 5 / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Images.arrownext,
                            width: MediaQuery.of(context).size.width * 5 / 100,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bg4color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: bg1Color,
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 5 / 100,
                    width: double.infinity,
                    color: bg1Color,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.5 / 100,
                        right: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.tugas,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          const Text(
                            "Tugas",
                            style: TextStyle(
                                color: bg4color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Lebih Banyak",
                                  style: TextStyle(
                                    color: bg4color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100,
                                ),
                                Image.asset(Images.arrownext)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _jadwal1(),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  _jadwal1(),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  _jadwal1(),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 12 / 100,
              decoration: BoxDecoration(
                color: bg4color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: bg1Color,
                  width: 3,
                ),
              ),
              child: Image.asset(
                Images.kartuabsen,
                width: 1000,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
