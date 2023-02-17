import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KorzinaPage extends StatefulWidget {
  const KorzinaPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<KorzinaPage> {

  /*void saveProduct(BasketClass basketClass) {
    //save product shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('basket', jsonEncode(basketClass.toJson()));
    });
  }*/
  var text = '';

  //getData from shared preferences
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //get data from shared preferences
    String? basket = prefs.getString('basket');
    print(basket);
    text = prefs.getString('basket')!;
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
          Text(text),
        ],
      ),
    );
  }
}