import 'package:flutter/material.dart';

class Jadwal extends StatefulWidget {
  const Jadwal(
      {super.key,
      required this.kegiatan,
      required this.jam,
      required this.tanggal});
  final String kegiatan;
  final String jam;
  final String tanggal;

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 2.5 / 100,
          right: MediaQuery.of(context).size.width * 4 / 100),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  this.value = value;
                });
              }
            },
          ),
          Text(
            widget.kegiatan,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 10 / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.jam,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
          Text(
            widget.tanggal,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
