import 'dart:convert';

import 'package:avto_qismlar/models/products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/histry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      var price ;
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
      }
      setState(() {});
    }
    getAllmoney();
  }

  String moneyFormat(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'uz_UZ',
      symbol: 'soʻm',
    );
    return formatter.format(amount).replaceAll(',00', '');
  }

  double countsMoney(double prise, double discount, double dollarRate) {
    prise = prise * dollarRate;
    discount = discount * dollarRate;
    prise = prise - discount;
    prise = prise / 100;
    prise = prise.ceilToDouble();
    prise = prise * 100;
    return prise;
  }

  String countMoney(double prise, double discount, double dollarRate) {
    prise = prise * dollarRate;
    discount = discount * dollarRate;
    prise = prise - discount;
    prise = prise / 100;
    prise = prise.ceilToDouble();
    prise = prise * 100;
    return moneyFormat(prise);
  }

  String countMoney1(double prise, double dollarRate) {
    prise = prise * dollarRate;
    prise = prise / 100;
    prise = prise.ceilToDouble();
    prise = prise * 100;
    return moneyFormat(prise);
  }

  //_orders 2 add data['products'][j].countMoney( data['products'][j].sellPrice, data['products'][j].discount, data['products'][j].dollar_rate)
  void getAllmoney() {
    //_orders2 add data['products'][j].countMoney( data['products'][j].sellPrice, data['products'][j].discount, data['products'][j].dollar_rate) * data['products'][j].count ?? 0
     for (var i = 0; i < data.length; i++) {
       var price = 0.0;
        for (var j = 0; j < data[i]['products'].length; j++) {
          price += countsMoney(
            double.parse(data[i]['products'][j]['sell_price']),
            double.parse(data[i]['products'][j]['discount']),
            double.parse(data[i]['products'][j]['dollar_rate'])
          )*double.parse(data[i]['products'][j]['count']);
        }
       _orders2.add(moneyFormat(price));
      }
     print(_orders2);
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
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.015,
          ),
          Text(
              AppLocalizations.of(context)?.tarix ?? '',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      //title: Text(_orders[index].date),
                      title: Text(_orders[index].date),
                      trailing: const Text('yangi',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                    ),
                    for (var i = 0; i < _orders[index].products.length; i++)
                      GestureDetector(
                        child: Card(
                          color: Colors.lime[50],
                          shadowColor: Colors.lime[50],
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              if (_orders[index].products[i].picture != '')
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'http://avtoqismlar.almirab.uz/public/uploads/products/${_orders[index].products[i].picture}'),
                                          fit: BoxFit.cover)),
                                ),
                              if (_orders[index].products[i].picture == '')
                                Container(
                                  width: MediaQuery.of(context)
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
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                                  Text(
                                      'Narxi:${_orders[index].products[i].count}x${countMoney(double.parse(_orders[index].products[i].sellPrice),double.parse(_orders[index].products[i].discount), double.parse(_orders[index].products[i].dollarRate))}',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54)),
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
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Jami: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_orders2[index]}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
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
