import 'dart:convert';

import 'package:avto_qismlar/models/products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class KorzinaPage extends StatefulWidget {
  const KorzinaPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<KorzinaPage> {
  final _productList = [];
  var counter = [];
  var cId;

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    cId = prefs.getString('client_id') ?? '';
    print(cId);

    String? basket = prefs.getString('basket');
    var data = jsonDecode(basket!);
    List<dynamic> products = data['products'];
    for (var product in products) {
      ProductClass productClass = ProductClass.fromJson(product);
      _productList.add(productClass);
    }
    setState(() {
      counter = List.generate(
          _productList.length, (index) => int.parse(_productList[index].count));
    });
    getAllmoney();
  }

  //delete product from basket and update basket in shared preferences
  Future<void> deleteProduct(int index) async {
    final prefs = await SharedPreferences.getInstance();
    String? basket = prefs.getString('basket');
    var data = jsonDecode(basket!);
    List<dynamic> products = data['products'];
    products.removeAt(index);
    data['products'] = products;
    prefs.setString('basket', jsonEncode(data));
    _productList.removeAt(index);
    setState(() {});
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

  String getAllmoney() {
    var price = 0.0;
    for (var i = 0; i < _productList.length; i++) {
      price += countsMoney(
          double.parse(_productList[i].sellPrice),
          double.parse(_productList[i].discount),
          double.parse(_productList[i].dollarRate)
      )*double.parse(_productList[i].count);
    }
    print(price);
    return moneyFormat(price);
  }



  Future<void> createOrder() async {
    final prefs = await SharedPreferences.getInstance();
    cId = prefs.getString('client_id') ?? '';
    //mutable list of products
    List<ProductClass> _productsList = [];

    String? basket = prefs.getString('basket');
    var data = jsonDecode(basket!);
    List<dynamic> products = data['products'];
    for (var product in products) {
      ProductClass productClass = ProductClass.fromJson(product);
      _productsList.add(productClass);
    }
    final response = await http.post(
      Uri.parse('http://avtoqismlar.almirab.uz/api/create_order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'client_id': cId,
        'products': _productsList,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('success');
      prefs.remove('basket');
      _productList.clear();
      setState(() {});
    }else{
      print('error');
    }
  }

  String moneyFormat(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'uz_UZ',
      symbol: 'soʻm',
    );
    return formatter.format(amount).replaceAll(',00', '');
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

  @override
  void initState() {
    getData();
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
          if (_productList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: _productList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                            if (_productList[index].picture != '')
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'http://avtoqismlar.almirab.uz/public/uploads/products/${_productList[index].picture}'),
                                        fit: BoxFit.cover)),
                              ),
                            if (_productList[index].picture == '')
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://1gai.ru/uploads/posts/2019-04/1554288456_vfd.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(_productList[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Row(
                                  children: [
                                    const Text('Brend:',
                                        style: TextStyle(
                                          fontSize: 13,
                                        )),
                                    Text(
                                        '${_productList[index].brand.toUpperCase()}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.orange)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text('${_productList[index].country}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.003),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.61,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  countMoney(
                                                      double.parse(
                                                          _productList[index]
                                                              .sellPrice),
                                                      double.parse(
                                                          _productList[index]
                                                              .discount),
                                                      double.parse(
                                                          _productList[index]
                                                              .dollarRate)),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.003),
                                          if (_productList[index].discount !=
                                              "0.00")
                                            Text(
                                                countMoney1(
                                                    double.parse(
                                                        _productList[index]
                                                            .sellPrice),
                                                    double.parse(
                                                        _productList[index]
                                                            .dollarRate)),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.red,
                                                )),
                                        ],
                                      ),
                                      const Expanded(child: Text('')),
                                      if (_productList[index].guarantee == '1')
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                              ),
                                              const Text(
                                                'Kafolat',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.green),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.61,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            //counter index update --
                                            if (counter[index] > 1) {
                                              setState(() {
                                                counter[index] = counter[index] - 1;
                                              });
                                            }
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          )),
                                      Text(counter[index].toString(),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                          onPressed: () {
                                            counter[index] = counter[index] + 1;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          )),
                                      const Expanded(child: Text('')),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black54,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            deleteProduct(index);
                                          });
                                        },
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    );
                  }),
            ),
          if(_productList.isEmpty)
            Expanded(child: Container()),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(1.0, 1.0),
                )
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    const Text(
                      'Jami:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(getAllmoney(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.white,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: TextButton(
                        child: const Text(
                          'Buyurtma berish',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          createOrder();
                        }),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
