import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../models/products.dart';

class ProductDetail extends StatefulWidget {
  var productId;
  var categoryId;
  var categoryName;

  ProductDetail(
      {super.key, this.productId, this.categoryId, this.categoryName});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  List<String> imgList = [];
  var _current = 0;
  var name = "";
  late ProductClass productClass;
  var isLoading = true;
  var duration = const Duration(seconds: 3);
  var _similars = [];

  Future<void> _getData() async {
    final response = await http.get(
        Uri.parse(
            "http://avtoqismlar.almirab.uz/api/get_product_similar/${widget.productId}/${widget.categoryId}"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        });
    if (response.statusCode == 200) {
      isLoading = true;
      imgList.clear();
      json.decode(response.body);
      var data = json.decode(response.body);
      productClass = ProductClass.fromJson(data['product']);

      if (json.decode(response.body)['productImages'].length > 0) {
        for (var i = 0; i < data['productImages'].length; i++) {
          imgList.add(
              'http://avtoqismlar.almirab.uz/public/uploads/products/${json.decode(response.body)['productImages'][i]['picture']}');
        }
      } else {
        imgList.add('https://1gai.ru/uploads/posts/2019-04/1554288456_vfd.jpg');
      }
      for (var i = 0; i < data['similarProducts'].length; i++) {
        _similars.add(ProductClass(
          id: data['similarProducts'][i]['id'],
          name: data['similarProducts'][i]['name'],
          nameRu: data['similarProducts'][i]['name_ru'],
          code: data['similarProducts'][i]['code'],
          productTypeId: data['similarProducts'][i]['product_type_id'],
          countryId: data['similarProducts'][i]['country_id'],
          brandId: data['similarProducts'][i]['brand_id'],
          measurement: data['similarProducts'][i]['measurement'],
          price: data['similarProducts'][i]['price'],
          sellPrice: data['similarProducts'][i]['sell_price'],
          discount: data['similarProducts'][i]['discount'],
          count: data['similarProducts'][i]['count'],
          guarantee: data['similarProducts'][i]['guarantee'],
          picture: data['similarProducts'][i]['picture'] ?? "",
          description: data['similarProducts'][i]['description'] ?? "",
          minCount: data['similarProducts'][i]['min_count'],
          createdAt: data['similarProducts'][i]['created_at'],
          updatedAt: data['similarProducts'][i]['updated_at'],
          country: data['similarProducts'][i]['country'],
          countryRu: data['similarProducts'][i]['country_ru'],
          brand: data['similarProducts'][i]['brand'],
          categoryId: data['similarProducts'][i]['category_id'],
          dollarRate: data['similarProducts'][i]['dollar_rate'],
        ));
        print(_similars[i].picture);
      }
      if (data['productImages'].length > 1) {
        duration = const Duration(seconds: 6);
      } else {
        duration = const Duration(seconds: 0);
      }
      isLoading = false;
      setState(() {});
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
    print(widget.productId);
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.indigo,
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
              0.05), // here the desired height
          child: AppBar(
            backgroundColor: Colors.indigo,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.257,
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    autoPlayInterval: duration,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.ease,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imgList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                            image: DecorationImage(
                              image: NetworkImage(i),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    productClass.name ?? '',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    countMoney(
                        double.parse(productClass.sellPrice),
                        double.parse(productClass.discount),
                        double.parse(productClass.dollarRate)),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            if (productClass.discount != '0.00')
              Container(
                margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      countMoney1(double.parse(productClass.sellPrice),
                          double.parse(productClass.dollarRate)),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: const EdgeInsets.only(top: 10),
                  color: Colors.black,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Row(
                children: [
                  const Text(
                    'Brend: ',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  Text(
                    productClass.brand,
                    style: const TextStyle(fontSize: 18, color: Colors.orange),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            //cauntry
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const Text(
                    'Davlat: ',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  Text(
                    productClass.country,
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            //category
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const Text(
                    'Kategoriya: ',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  Text(
                    '${widget.categoryName}',
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              color: Colors.black,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text('Oxshash mahsulotlar'),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _similars.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 5,
                        color: Colors.white,
                        margin: const EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productId: _similars[index].id,
                                  categoryId: _similars[index].categoryId,
                                  categoryName: widget.categoryName,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_similars[index].picture != '')
                                  Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          topRight: Radius.circular(3)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'http://avtoqismlar.almirab.uz/public/uploads/products/${_similars[index].picture}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                if (_similars[index].picture == '')
                                  Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          topRight: Radius.circular(3)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://1gai.ru/uploads/posts/2019-04/1554288456_vfd.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 2, left: 5),
                                  child: Text(
                                    _similars[index].name,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(top: 1, left: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          _similars[index].brand + ' ',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.orange),
                                        ),
                                        Text(
                                          _similars[index].country,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.green),
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 1, left: 5),
                                  child: Text(
                                    countMoney(
                                        double.parse(_similars[index].sellPrice),
                                        double.parse(_similars[index].discount),
                                        double.parse(_similars[index].dollarRate)),
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
}
