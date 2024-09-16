import 'package:flutter/material.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/absen/absen_screen.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/dahboard/dasboard_screen.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/profile/profile_screen.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/rekap/rekap.dart';
import 'package:mobile2karyawan/views/screens/dashboardscreens/tugas/tugas_screen.dart';

import '../theme.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DasboardScreen(),
    const AbsenScreen(),
    const RekapScreen(),
    const TugasScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    Widget customButtomNav() {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: bg1Color,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    Images.home,
                    width: 24.0,
                  ),
                ),
                if (_currentIndex == 0)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    Images.absen,
                    width: 24.0,
                  ),
                ),
                if (_currentIndex == 1)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Absen',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Icon(Icons.dashboard)),
                if (_currentIndex == 2)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Rekap',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    Images.tugas,
                    width: 24.0,
                  ),
                ),
                if (_currentIndex == 3)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(
                    10,
                  ),
                  child: Image.asset(
                    Images.profile,
                    width: 24.0,
                  ),
                ),
                if (_currentIndex == 4)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: bg4color,
        unselectedItemColor: bg4color,
      );
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        child: customButtomNav(),
      ),
    );
  }
}
