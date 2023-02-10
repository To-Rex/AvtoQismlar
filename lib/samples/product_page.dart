import 'dart:convert';

import 'package:avto_qismlar/models/products.dart';
import 'package:avto_qismlar/samples/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  var id;
  var categoryName;

  ProductPage({super.key, this.id, this.categoryName});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  final _productList = [];
  var _listProduct = [];
  var isSearch = false;
  var isLoading = true;
  var counter = [];

  Future<void> getCategory() async {
    final response = await http.get(Uri.parse(
        "http://avtoqismlar.almirab.uz/api/get_products/${widget.id}"));
    if (response.statusCode == 200) {
      json.decode(response.body);
      for (var i = 0; i < json.decode(response.body).length; i++) {
        _productList.add(ProductClass(
          id: json.decode(response.body)[i]['id'] ?? "",
          name: json.decode(response.body)[i]['name'] ?? "",
          nameRu: json.decode(response.body)[i]['name_ru'] ?? "",
          code: json.decode(response.body)[i]['code'] ?? "",
          productTypeId: json.decode(response.body)[i]['product_type_id'] ?? "",
          countryId: json.decode(response.body)[i]['country_id'] ?? "",
          brandId: json.decode(response.body)[i]['brand_id'] ?? "",
          measurement: json.decode(response.body)[i]['measurement'] ?? "",
          price: json.decode(response.body)[i]['price'] ?? "",
          sellPrice: json.decode(response.body)[i]['sell_price'] ?? "",
          discount: json.decode(response.body)[i]['discount'] ?? "",
          count: json.decode(response.body)[i]['count'] ?? "",
          guarantee: json.decode(response.body)[i]['guarantee'] ?? "",
          picture: json.decode(response.body)[i]['picture'] ?? "",
          description: json.decode(response.body)[i]['description'] ?? "",
          minCount: json.decode(response.body)[i]['min_count'] ?? "",
          createdAt: json.decode(response.body)[i]['created_at'] ?? "",
          updatedAt: json.decode(response.body)[i]['updated_at'] ?? "",
          country: json.decode(response.body)[i]['country'] ?? "",
          countryRu: json.decode(response.body)[i]['country_ru'] ?? "",
          brand: json.decode(response.body)[i]['brand'] ?? "",
          categoryId: json.decode(response.body)[i]['category_id'] ?? "",
          dollarRate: json.decode(response.body)[i]['dollar_rate'] ?? "",
        ));
        counter.add(1);
      }
      _listProduct = _productList;
      isLoading = false;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Xatolik yuz berdi!'),
      ));
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
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Row(
            children: [
              const Spacer(),
              if (isSearch)
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                ),
              if (isSearch)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      textAlign: TextAlign.justify,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _listProduct = _productList
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Qidirish",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isSearch)
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                ),
              //korzina icon
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.height * 0.02),
              Text(widget.categoryName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          if (isLoading)
            const Center(
                child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.indigoAccent,
              ),
            )),
          if (!isLoading)
            if (_listProduct.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: _listProduct.length,
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
                              if (_listProduct[index].picture != '')
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage('http://avtoqismlar.almirab.uz/public/uploads/products/${_listProduct[index].picture}'),
                                        fit: BoxFit.cover)),
                              ),
                              if (_listProduct[index].picture == '')
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: NetworkImage('https://1gai.ru/uploads/posts/2019-04/1554288456_vfd.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Text(_listProduct[index].name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Row(
                                    children: [
                                      const Text('Brend:',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                      Text(
                                          '${_listProduct[index].brand.toUpperCase()}',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.orange)),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      Text('${_listProduct[index].country}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 13,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.003),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.61,
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
                                                            _listProduct[index]
                                                                .sellPrice),
                                                        double.parse(
                                                            _listProduct[index]
                                                                .discount),
                                                        double.parse(
                                                            _listProduct[index]
                                                                .dollarRate)),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.003),
                                            if (_listProduct[index].discount != "0.00")
                                              Text(
                                                  countMoney1(
                                                      double.parse(
                                                          _listProduct[index]
                                                              .sellPrice),
                                                      double.parse(
                                                          _listProduct[index]
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
                                        if (_listProduct[index].guarantee ==
                                            '1')
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
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            //counter index update --
                                            if (counter[index] > 1) {
                                              setState(() {
                                                counter[index] =
                                                    counter[index] - 1;
                                                //counter--;
                                              });
                                            }
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
                                            setState(() {
                                              counter[index] =
                                                  counter[index] + 1;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.21),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //send _listProduct ProductClass to ProductDetailPage and open ProductDetailPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                //product id and category id send to ProductDetailPage
                                productId: _listProduct[index].id,
                                categoryId: _listProduct[index].categoryId,
                                categoryName: widget.categoryName,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
          if (!isLoading)
            if (_listProduct.isEmpty)
              const Center(
                child: Text('Mahsulot topilmadi'),
              ),
        ],
      ),
    );
  }
}
