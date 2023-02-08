import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class KorzinaPage extends StatefulWidget {
  const KorzinaPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<KorzinaPage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
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
        children: const [
          //combobox for language change english and russian and uzbek
          
        ],
      ),
    );
  }
}