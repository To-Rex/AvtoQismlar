import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'confirmation.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();

  //http://avtoqismlar.almirab.uz/api/register
  Future<void> _register() async {
    final response = await http.post(
      Uri.parse('http://avtoqismlar.almirab.uz/api/register'),
      body: {
        'phone': '+998${_phoneController.text}',
        'fullName': _nameController.text,
        'address': _countryController.text,
        'deviceName': 'Android',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errorMessages'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ro\'yxatdan o\'tish muvaffaqiyatli amalga oshdi!'),
          ),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirPage(
                  phoneNumber: '+998${_phoneController.text}',
                )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['errorMessages'][0].toString()),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xatolik yuz berdi!'),
        ),
      );
    }
  }


  @override
  void initState() {
    _phoneController.clear();
    _nameController.clear();
    _countryController.clear();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.indigo,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              AspectRatio(
                  aspectRatio: 1.5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      const Text(
                        'Ro\'yxatdan o\'tish',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                        'Ro\'yxatdan o\'tish uchun',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'ismingiz',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' va',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' telefon raqamingizni',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'mobil operator kodi bilan kiriting!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              border: Border.all(
                                  color: Colors.indigo,
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: const Center(
                              child: Text(
                                '+998',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.002,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              border:
                                  Border.all(color: Colors.indigo, width: 1),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Telefon raqam',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //ism
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                //ism
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ismingiz',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  ),
                ),
                //Manzil
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _countryController,
                    keyboardType: TextInputType.text,
                    style:  const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Manzilingiz',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  ),
                ),
                //Yuborish
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                      onPressed: () {
                        /*if(_phoneController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Telefon raqamni kiriting'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 1000),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        if(_phoneController.text.length < 5){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Telefon raqamni to\'g\'ri kiriting'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 1000),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        if(_nameController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ismingizni kiriting'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 1000),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }*/
                        _register();
                      },
                      child: const Text(
                        'Yuborish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
