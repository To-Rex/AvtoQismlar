import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/histry.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  var _orders = [];
  var _orders2 = [];

  Future<void> _getSharedPref() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    _getOrders();
  }

  Future<void> _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://avtoqismlar.almirab.uz/api/client_orders/${prefs.getString('client_id')}');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var i = 0; i < data.length; i++) {
        var date = data[i]['date'];
        var total = data[i]['total'];
        var status = data[i]['status'];
        var id = data[i]['id'];
        _orders.add(HistoryClass(
            date: date,
            total: total,
            status: status,
            id: id,));
      }
      print(_orders.length);
    }
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
        body: Center(
          child: Text('History'),
        )
        /*body: Column(
        children: [
          //text Tarix
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: const Text('Tarix',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //itemCount: _similars.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [

                  ],
                );
              },
            ),
          ),

        ],
      ),*/
        );
  }
}
