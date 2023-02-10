import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SampesPageState createState() => _SampesPageState();
}

class _SampesPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
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
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                //location icon and text
                const Icon(Icons.location_on, color: Colors.indigo),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.005,
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: const Text('Qo`qon',
                      style: TextStyle(color: Colors.indigo)),
                ),
                Expanded(child: Container()),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.indigo),
                  itemBuilder: (context) => [
                    //edit profile button and icon
                    PopupMenuItem(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.edit, color: Colors.indigo),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                  AppLocalizations.of(context)!.editProfile,
                                  style: const TextStyle(color: Colors.indigo)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.logout, color: Colors.redAccent),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: const TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration:  BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.5)),
                  ),
                  child: Center(
                    child: Text('A',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: Container()),
                const Text(
                    'Abdulaziz Abdurahmonov',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Expanded(child: Container()),
              ],
            ),
          ),
          //phone number
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: Container()),
                const Text(
                    '+998 97 123 45 67',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,)),
                Expanded(child: Container()),
              ],
            ),
          ),

          Expanded(child: Container()),
          Row(
            children: [
              Expanded(child: Container()),
              Container(
                width: 20,
                height: 20,
                decoration:  BoxDecoration(
                  color: color1,
                  //in the form of a circle with a radius of 50
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 2,
                decoration:  BoxDecoration(
                  color: color1,
                  //in the form of a circle with a radius of 50
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration:  BoxDecoration(
                  color: color1,
                  //in the form of a circle with a radius of 50
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 2,
                decoration:  BoxDecoration(
                  color: color2,
                  //in the form of a circle with a radius of 50
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration:  BoxDecoration(
                  color: color2,
                  //in the form of a circle with a radius of 50
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),

          //name and surname

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
                    color2 = Colors.black45;
                    color1 = Colors.indigo;
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
                    color1 = Colors.black45;
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
          //Logout button

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