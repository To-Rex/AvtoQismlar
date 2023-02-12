import 'dart:convert';

import 'package:avto_qismlar/models/products.dart';
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
  var data;

  Future<void> _getSharedPref() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    _getOrders();
  }

  Future<void> _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://avtoqismlar.almirab.uz/api/client_orders/${prefs.getString('client_id')}');
    var response = await http.get(url);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _orders.clear();
      _orders2.clear();
      for (var i = 0; i < data.length; i++) {
        var date = data[i]['date']??'';
        var total = data[i]['total']??'';
        var status = data[i]['status']??'';
        var id = data[i]['id']??'';
        _orders.add(HistoryClass(
            date: date,
            total: total,
            status: status,
            id: id,));
        /*for (var j = 0; j < data[i]['products'].length; j++) {
          _orders2.add(ProductClass.fromJson(
              Map<String, dynamic>.from(data[i]['products'][j])
          ));
        }*/
        /*for(data in data[i]['products']){
          _orders2.add(ProductClass.fromJson(
              Map<String, dynamic>.from(data)
          ));
        }*/
      }
      print(_orders.length);
      setState(() {});
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
        body: Column(
        children: [
          Text('History'),
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(_orders[index].date),
                      trailing: Text(_orders[index].status),
                    ),

                    Divider(
                      endIndent: 10,
                      indent: 10,
                      color: Colors.black54,
                      height: 1,
                      thickness: MediaQuery.of(context).size.width * 0.002,
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
