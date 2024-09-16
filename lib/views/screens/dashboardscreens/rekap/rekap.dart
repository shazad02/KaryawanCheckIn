import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';

class Tugas {
  final String nama;
  final String waktu;
  final String tanggal;

  Tugas({
    required this.nama,
    required this.waktu,
    required this.tanggal,
  });
}

class RekapScreen extends StatefulWidget {
  const RekapScreen({Key? key}) : super(key: key);

  @override
  State<RekapScreen> createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  List<Tugas> daftarTugas = [
    Tugas(
      nama: "03-11-2024",
      waktu: "08:15",
      tanggal: "16:10",
    ),
    Tugas(
      nama: "04-11-2024",
      waktu: "08:20",
      tanggal: "16:15",
    ),
    Tugas(
      nama: "05-11-2024",
      waktu: "08:17",
      tanggal: "16:05",
    ),
  ];

  List<bool> values = [
    false,
    false,
    false
  ]; // List untuk menyimpan nilai checkbox

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rekap Absensi    ",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isChecked = value;
                        });
                      }
                    },
                  ),
                  const Text(
                    "hadir",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked1,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isChecked1 = value;
                        });
                      }
                    },
                  ),
                  const Text(
                    "Sakit",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked2,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isChecked2 = value;
                        });
                      }
                    },
                  ),
                  const Text(
                    "Izin",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 3 / 100,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 5 / 100,
                right: MediaQuery.of(context).size.width * 13 / 100),
            child: Row(
              children: [
                const Text(
                  "Tanggal  ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 20 / 100,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Pagi",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                      const Text(
                        "sore",
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
