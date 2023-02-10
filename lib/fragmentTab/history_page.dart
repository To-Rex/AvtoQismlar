import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {

  //function for getting data from shared preferences
  Future<void> _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    print(prefs.getString('codeVerified'));
    print(prefs.getString('fullName'));
    print(prefs.getString('phone'));
    print(prefs.getString('address'));
    print(prefs.getString('client_id'));
  }

  @override
  void initState() {
    _getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.indigo,
        ),
      ),
      body: Column(
        children: [
          Text('jjjhjhjhjjhjhhj'),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}