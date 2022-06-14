import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Helper/ColorsRes.dart';
import '../../Helper/String.dart';
import '../../localization/Demo_Localization.dart';
import '../home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark_mode ? Brightness.dark : Brightness.light,
      ),
    );
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Mainpage(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark_mode ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.white,
      body: Container(
        color: dark_mode ? ColorsRes.backgroundColor : ColorsRes.grey,
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                      Image.asset("assets/images/splash_logo.png"),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        DemoLocalization.of(context).translate("FLUTTER"),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: ColorsRes.appColor,
                        ),
                      ),
                      Text(
                        DemoLocalization.of(context).translate("OFFLINE"),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: ColorsRes.appColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        DemoLocalization.of(context).translate("EBOOK APP"),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: ColorsRes.appColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Language_flag == "ar"
                    ? Image.asset("assets/images/books_splashrtl.png")
                    : Image.asset("assets/images/books_splash.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
