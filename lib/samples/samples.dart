import 'package:avto_qismlar/fragmentTab/home_page.dart';
import 'package:flutter/material.dart';
import '../fragmentTab/history_page.dart';
import '../fragmentTab/korzina_page.dart';
import '../fragmentTab/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SamplesPage extends StatefulWidget {
  const SamplesPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<SamplesPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
    KorzinaPage(),
    SettingsPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        backgroundColor: const Color.fromRGBO(33, 158, 188, 10),
        items:  const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restore),
            activeIcon: Icon(Icons.restore),
            label: 'Tables',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        onTap: _onItemTapped,
      ),
    );
  }
}