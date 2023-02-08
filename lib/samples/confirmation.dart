import 'dart:async';
import 'dart:convert';

import 'package:avto_qismlar/samples/samples.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConfirPage extends StatefulWidget {
  var phoneNumber;
  ConfirPage({super.key, required this.phoneNumber});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<ConfirPage>
    with SingleTickerProviderStateMixin {


  late CountdownTimerController controller;
  final _codeControllers = TextEditingController();
  //30 seconds
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  var isTimerEnd = false;
  var deviceModel = '';

  //device model name for android and ios devices
  void getDeviceModel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      deviceModel = 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      deviceModel = 'ios';
    }
  }


  Future<void> _cheskCode() async {
    getDeviceModel();
    final response = await http.post(
      Uri.parse(
          'http://avtoqismlar.almirab.uz/api/check_registration_code'),
      body: {
        'phone': widget.phoneNumber.toString(),
        'code': _codeControllers.text.toString(),
        'deviceName': deviceModel.toString()
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      if (data['codeVerified'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hisobingiz tasdiqlandi'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 2700),
            behavior: SnackBarBehavior.floating,
          ),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['token']);
        prefs.setString('codeVerified', data['codeVerified'].toString());
        prefs.setString('fullName', data['fullName']);
        prefs.setString('phone', data['phone']);
        prefs.setString('address', data['address']);
        prefs.setString('client_id', data['client_id'].toString());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SamplesPage()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kod noto\'g\'ri'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xatolik yuz berdi'),
        ),
      );
    }
  }

  Future<void> _phonePost() async {
    final response = await http.post(
        Uri.parse('http://avtoqismlar.almirab.uz/api/check_user_phone'),
        body: {'phone': widget.phoneNumber.toString()});
    if (response.statusCode == 200) {

    }
  }

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    _codeControllers.dispose();
    super.dispose();
  }

  void onEnd() {
    isTimerEnd = true;
    setState(() {});
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
                height: MediaQuery.of(context).size.height * 0.20,
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
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('SMS orqali kelgan', style: TextStyle(fontSize: 16)),
              Text(' kodni ',
                  style: TextStyle(color: Colors.orange, fontSize: 16)),
              Text('tasdiqlash maydoniga kiriting',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
          const Text('Agar kod kelmasa 3 daqiqadan keyin qayta yuborishni',
              style: TextStyle(fontSize: 16)),
          const Text('so`rashingiz mumkin.', style: TextStyle(fontSize: 16)),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CountdownTimer(
            controller: controller,
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return Container();
              }
              return Text(
                '0${time.min ?? 0}:${time.sec ?? 0}',
                style: const TextStyle(fontSize: 30),
              );
            },
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _codeControllers,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '******',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                if(isTimerEnd)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Kod kelmadimi?', style: TextStyle(color: Colors.black),),
                      TextButton(
                        onPressed: () {
                          _phonePost();
                          isTimerEnd = false;
                          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                          controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
                          setState(() {
                          });
                        },
                        child: const Text('Qayta yuborish',
                            style: TextStyle(color: Colors.orange),), ),
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
                      if (_codeControllers.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kodni kiriting'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(milliseconds: 2700),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      if (_codeControllers.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kodni to`liq kiriting'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(milliseconds: 2700),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      _cheskCode();
                    },
                    child: const Text(
                      'Tasdiqlash',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
