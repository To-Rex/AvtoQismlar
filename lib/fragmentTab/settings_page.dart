import 'package:avto_qismlar/classes/language.dart';
import 'package:avto_qismlar/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  Color color1 = Colors.indigo;
  Color color2 = Colors.black87;

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
        children: [
          Text(AppLocalizations.of(context)!.submitInfo),
          Expanded(child: Container()),
          Row(
            children: [
              Expanded(child: Container()),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration:  BoxDecoration(
                  color: color1,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(13),
                    topLeft: Radius.circular(13),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    color2 = Colors.black87;
                    color1 = Colors.indigo;
                    //set lacale
                    MyApp.setLocale(context, const Locale('en'));
                    setState(() {});
                  },
                  child: const Center(
                    child: Text('Uzbekcha',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration:  BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    color2 = Colors.indigo;
                    color1 = Colors.black87;
                    //set lacale
                    MyApp.setLocale(context, const Locale('ru'));
                    setState(() {});

                  },
                  child: const Center(
                    child: Text('Русский',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}