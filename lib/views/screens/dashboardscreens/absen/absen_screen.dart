import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/absen/form_absen.dart';
import 'package:mobile2karyawan/widget/multi_buttom.dart';
import 'package:table_calendar/table_calendar.dart';

class AbsenScreen extends StatefulWidget {
  const AbsenScreen({Key? key}) : super(key: key);

  @override
  State<AbsenScreen> createState() => _AbsenScreenState();
}

class _AbsenScreenState extends State<AbsenScreen> {
  DateTime today = DateTime.now();

  void _onDaySelect(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  bool isTimeToClick(DateTime startTime, DateTime endTime) {
    DateTime currentTime = DateTime.now();
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  Widget _buttonHadir() {
    if (isTimeToClick(DateTime(today.year, today.month, today.day, 1),
        DateTime(today.year, today.month, today.day, 9))) {
      return MultiBottom(
        textButton: "Konfirmasi Kehadiran Pagi",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const FormAbsen(),
            ),
          );
        },
        buttomcolor: bg1Color,
        textcolor: bg4color,
      );
    } else {
      return const Text(
        "Bukan Waktunya Absensi Kehadiran",
        style: TextStyle(color: Colors.red),
      );
    }
  }

  Widget _buttonPulang() {
    if (isTimeToClick(DateTime(today.year, today.month, today.day, 16),
        DateTime(today.year, today.month, today.day, 17))) {
      return MultiBottom(
        textButton: "Konfirmasi Kehadiran Sore",
        onPressed: () {},
        buttomcolor: bg1Color,
        textcolor: bg4color,
      );
    } else {
      return const Text(
        "Bukan Waktunya Absensi Pulang",
        style: TextStyle(color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Absen",
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
          Container(
            child: TableCalendar(
              availableGestures: AvailableGestures.all,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              focusedDay: today,
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2010, 10, 10),
              lastDay: DateTime.utc(2050, 10, 10),
              sixWeekMonthsEnforced: true,
              onDaySelected: _onDaySelect,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
          _buttonHadir(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          _buttonPulang()
        ],
      ),
    );
  }
}
