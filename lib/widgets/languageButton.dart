import 'package:book/Helper/String.dart';
import 'package:flutter/material.dart';

import '../../Helper/ColorsRes.dart';
import '../../localization/Demo_Localization.dart';
import '../../localization/language_constants.dart';

class LanguageWidget extends StatefulWidget {
  final Function? update;
  bool? fromHome;

  LanguageWidget({Key? key, this.update, this.fromHome}) : super(key: key);

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            showMenu<String>(
              color: dark_mode ? ColorsRes.appColor : ColorsRes.grey,
              context: context,
              position: RelativeRect.fromLTRB(0, width! * 0.64, 0, 0.0),
              items: [
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("ENGLISH"),
                        style: const TextStyle(color: Colors.white)),
                    value: '0'),
                PopupMenuItem<String>(
                    child: Text(DemoLocalization.of(context).translate("HINDI"),
                        style: const TextStyle(color: Colors.white)),
                    value: '1'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("CHINESE"),
                        style: const TextStyle(color: Colors.white)),
                    value: '2'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("SPANISH"),
                        style: const TextStyle(color: Colors.white)),
                    value: '3'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("ARABIC"),
                        style: const TextStyle(color: Colors.white)),
                    value: '4'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("RUSSIAN"),
                        style: const TextStyle(color: Colors.white)),
                    value: '5'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("JAPANESE"),
                        style: const TextStyle(color: Colors.white)),
                    value: '6'),
                PopupMenuItem<String>(
                    child: Text(
                        DemoLocalization.of(context).translate("DEUTCH"),
                        style: const TextStyle(color: Colors.white)),
                    value: '7'),
              ],
              elevation: 7.0,
            ).then<void>(
              (String? itemSelected) {
                if (itemSelected == null) return;
                if (itemSelected == "0") {
                  setState(() async {
                    changeLanguage(context, "en");
                  });
                  widget.update;
                } else if (itemSelected == "1") {
                  setState(() async {
                    changeLanguage(context, "hi");
                  });
                  widget.update;
                } else if (itemSelected == "2") {
                  setState(() {
                    changeLanguage(context, "zh");
                  });
                  widget.update;
                } else if (itemSelected == "3") {
                  setState(() {
                    changeLanguage(context, "es");
                  });
                  widget.update;
                } else if (itemSelected == "4") {
                  setState(() {
                    changeLanguage(context, "ar");
                  });
                  widget.update;
                } else if (itemSelected == "5") {
                  setState(() {
                    changeLanguage(context, "ru");
                  });
                  widget.update;
                } else if (itemSelected == "6") {
                  setState(() {
                    changeLanguage(context, "ja");
                  });
                  widget.update;
                } else if (itemSelected == "7") {
                  setState(() {
                    changeLanguage(context, "de");
                  });
                  widget.update;
                }
              },
            );
          },
        );
      },
      child: widget.fromHome!
          ? Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: ColorsRes.appColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    "assets/images/language_icon.png",
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        DemoLocalization.of(context).translate("language"),
                        style: TextStyle(
                          fontSize: 10,
                          color: ColorsRes.textcolor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: height! * 0.055,
              width: width! * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorsRes.appColor,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 4,
                    ),
                    child: Image.asset(
                      "assets/images/language_icon.png",
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DemoLocalization.of(context).translate("language"),
                      style: TextStyle(
                        color: ColorsRes.textcolor,
                        fontSize: 8,
                        fontFamily: "Popinns-ExtraLight",
                        //       fontFamily: lang == true ? 'Arial' : 'MyFont',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
