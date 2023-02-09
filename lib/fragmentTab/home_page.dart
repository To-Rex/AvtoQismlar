import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../samples/login_page.dart';
import '../samples/product_page.dart';
import '../samples/register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _current;
  var userNumber = 0;
  List<String> imgList = [];
  var categories = [];

  var Id = '';
  var Name = '';
  var Sort = '';
  var Picture = '';
  var Active = '';

  var fullName = '';
  var phone = '';
  var address = '';
  var token = '';
  var codeVerified = '';
  var client_id = '';

  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      token = prefs.getString('token') ?? '';
      codeVerified = prefs.getString('codeVerified') ?? '';
      client_id = prefs.getString('client_id') ?? '';
    });
  }

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('http://avtoqismlar.almirab.uz/api/get_ads'));
    userNumber = 0;
    if (response.statusCode == 200) {
      imgList.clear();
      final data = jsonDecode(response.body);
      userNumber = data['clientsCount'];
      for (var i = 0; i < data['pictures'].length; i++) {
        imgList.add('http://avtoqismlar.almirab.uz/public/uploads/ads/${data['pictures'][i]}');
      }
      _getCategory();
      setState(() {});
    } else {
      imgList.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load images'),
        ),
      );
      throw Exception('Failed to load images');
    }
  }

  Future<void> _getCategory() async {
    final response = await http
        .get(Uri.parse('http://avtoqismlar.almirab.uz/api/get_categories'));
    if (response.statusCode == 200) {
      categories.clear();
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        categories.add(data[i]);
      }
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load categories'),
        ),
      );
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.indigo,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      AppLocalizations.of(context)!.autoPart.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width / 1.06,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        borderOnForeground: true,
                        elevation: 5,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.22,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(i),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.userCount+ userNumber.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        if (token.isEmpty)
                          TextButton(
                            onPressed: () {
                              //register page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.register.toString(),
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        Expanded(child: Container()),
                        if (token.isEmpty)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login.toString(),
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                  id: categories[index]['id'],
                                  categoryName: categories[index]['name'],
                                )),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      borderOnForeground: true,
                      elevation: 5,
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              'http://avtoqismlar.almirab.uz//public/uploads/categories/${categories[index]['picture']}',
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            categories[index]['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
