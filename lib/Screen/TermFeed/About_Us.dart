import 'package:flutter/material.dart';

import '../../Helper/ColorsRes.dart';
import '../../Helper/String.dart';
import '../../localization/Demo_Localization.dart';

class About_Us extends StatefulWidget {
  const About_Us({Key? key}) : super(key: key);

  @override
  _About_UsState createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark_mode ? ColorsRes.white : ColorsRes.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(DemoLocalization.of(context).translate("About Us")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            right: 15,
            left: 10,
          ),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: dark_mode ? ColorsRes.black : Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: DemoLocalization.of(context).translate("Welcome to "),
                ),
                TextSpan(
                  text: DemoLocalization.of(context)
                      .translate("Offline Book Application \n \n"),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: DemoLocalization.of(context).translate(
                      "Best Android & iOS app for reading a book is here. We guarantee you the best reading experience for you. \n \n"),
                ),
                TextSpan(
                  text: DemoLocalization.of(context)
                      .translate("Made with ❤ by "),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: DemoLocalization.of(context).translate("WRTeam "),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
