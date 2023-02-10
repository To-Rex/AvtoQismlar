import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  Color color1 = Colors.indigo;
  Color color2 = Colors.black45;

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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50, left: 20, right: 10),
            child: Row(
              children: [
                //icon person
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    //in the form of a circle with a radius of 50
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                const Text('Abdulaziz Abdurahmonov',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Expanded(child: Container()),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: Row(
              children: [
                //icon person
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    //in the form of a circle with a radius of 50
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                const Text('+998 97 777 77 77',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Expanded(child: Container()),
              ],
            ),
          ),
          //country
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: Row(
              children: [
                //icon person
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    //in the form of a circle with a radius of 50
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                const Text('Uzbekistan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Expanded(child: Container()),
              ],
            ),
          ),

          Expanded(child: Container()),
          Row(
            children: [
              Expanded(child: Container()),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(13),
                    topLeft: Radius.circular(13),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    color2 = Colors.black45;
                    color1 = Colors.indigo;
                    MyApp.setLocale(context, const Locale('en'));
                    setState(() {});
                  },
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.lotin,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    color2 = Colors.indigo;
                    color1 = Colors.black45;
                    MyApp.setLocale(context, const Locale('ru'));
                    setState(() {});
                  },
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.kiril,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          //Logout button

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          //logout icon button and text
          Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        //icon logout and text
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(AppLocalizations.of(context)!.logout,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
