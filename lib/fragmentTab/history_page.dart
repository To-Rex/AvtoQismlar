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
        'http://avtoqismlar.almirab.uz/api/client_orders/${prefs.getString(
            'client_id')}');
    var response = await http.get(url);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _orders.clear();
      _orders2.clear();
      for (var i = 0; i < data.length; i++) {
        _orders.add(HistoryClass(
            date: data[i]['date'] ?? '',
            total: data[i]['total'] ?? '',
            status: data[i]['status'] ?? '',
            id: data[i]['id'] ?? '',
            products: [
              for (var j = 0; j < data[i]['products'].length; j++)
                ProductClass.fromJson(data[i]['products'][j])
            ]));
        print('=====>> ${_orders[i].products.length}');
        //print('=====>> ${_orders[i].products[0].name}');
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
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(_orders[index].date),
                      trailing: Text(_orders2.length.toString()),
                    ),
                    //_orders2.product.length
                    for (var i = 0; i < _orders[index].products.length; i++)
                    //cardview for product
                      GestureDetector(
                        child: Card(
                          color: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              //if (_listProduct[index].picture != '')
                              if (_orders[index].products[i].picture != '')
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'http://avtoqismlar.almirab.uz/public/uploads/products/${_orders[index].products[i].picture}'),
                                          fit: BoxFit.cover)),
                                ),
                              if (_orders[index].products[i].picture == '')
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              'https://1gai.ru/uploads/posts/2019-04/1554288456_vfd.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                              SizedBox(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01),
                                  Text(_orders[index].products[i].name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01),
                                  Row(
                                    children: [
                                      const Text('Brend:',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                      Text(
                                          '${_orders[index].products[i].brand
                                              .toUpperCase()}',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.orange)),
                                      SizedBox(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.01),
                                      Text('${_orders[index].products[i].country}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 13,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.003),
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.61,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    Divider(
                      endIndent: 10,
                      indent: 10,
                      color: Colors.black54,
                      height: 1,
                      thickness: MediaQuery
                          .of(context)
                          .size
                          .width * 0.002,
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
