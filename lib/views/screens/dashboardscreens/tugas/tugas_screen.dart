import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';

class Tugas {
  final String nama;
  final String waktu;
  final String tanggal;
  final String iconPath;

  Tugas({
    required this.nama,
    required this.waktu,
    required this.tanggal,
    required this.iconPath,
  });
}

class TugasScreen extends StatefulWidget {
  const TugasScreen({Key? key}) : super(key: key);

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  List<Tugas> daftarTugas = [
    Tugas(
      nama: "Analisis Kegiatan",
      waktu: "23:45",
      tanggal: "7 Nov",
      iconPath: "assets/icons/Note.png",
    ),
    Tugas(
      nama: "Membuat Laporan",
      waktu: "20:30",
      tanggal: "1 Jul",
      iconPath: "assets/icons/Lightbulb.png",
    ),
    Tugas(
      nama: "Meeting Proyek",
      waktu: "20:30",
      tanggal: "4 Sept",
      iconPath: "assets/icons/Slide Layout.png",
    ),
  ];

  List<bool> values = [
    false,
    false,
    false
  ]; // List untuk menyimpan nilai checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Tugas",
          style: TextStyle(
            color: bg1Color,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 5 / 100,
                right: MediaQuery.of(context).size.width * 13 / 100),
            child: const Row(
              children: [
                Text(
                  "Nama Tugas",
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Batas Waktu",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: Colors.grey[400],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: daftarTugas.length,
              itemBuilder: (context, index) {
                final tugas = daftarTugas[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Checkbox(
                            value: values[index],
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  values[index] = value;
                                });
                              }
                            },
                          ),
                          Image.asset(
                            tugas.iconPath,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tugas.nama,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tugas.waktu,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                ),
                                Text(
                                  tugas.tanggal,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.grey[400],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
