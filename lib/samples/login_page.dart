import 'dart:convert';

import 'package:flutter/material.dart';
import 'confirmation.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _phone = TextEditingController();
  var err = '';
  var _isLoading = false;

  Future<void> _phonePost() async {
    _isLoading = true;
    setState(() {});
    final response = await http.post(
        Uri.parse('http://avtoqismlar.almirab.uz/api/check_user_phone'),
        body: {'phone': '+998${_phone.text}'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['isPhoneRegistered'] == true) {
        _isLoading = false;
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirPage(
                      phoneNumber: '+998${_phone.text}',
                    )));
      } else {
        _isLoading = false;
        err = data['errorMessage'];
        setState(() {});
        _showMyDialog();
      }
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.error, color: Colors.red),
              Text('  Xatolik!'),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(err),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Berkitish', style: TextStyle(color: Colors.lightGreen)),
              onPressed: () {
                _isLoading = false;
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
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
                        'Kirish',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Dasturga kirish uchun ',style: TextStyle(color: Colors.white),),
                          Text('telefon raqamingizni',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),),
                          Text(' kiriting!',style: TextStyle(color: Colors.white),),
                        ],
                      )
                    ],
                  )),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
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
                              border: Border.all(color: Colors.indigo, width: 1),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextField(
                              controller: _phone,
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
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if(_phone.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Telefon raqamni kiriting!'),
                          ),
                        );
                        _phone.clear();
                        return;
                      }
                      if(_phone.text.length <= 4){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Telefon raqamni to`liq kiritign'),
                          ),
                        );
                        _phone.clear();
                        return;
                      }
                      _phonePost();
                    },
                    child: const Text(
                      'Yuborish',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                if(_isLoading)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Column(
                    children: [
                      const Text('Iltimos kuting...',style: TextStyle(color: Colors.black),),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.003,
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
