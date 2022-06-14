import 'package:flutter/material.dart';
import '../../Helper/ColorsRes.dart';
import '../../Helper/String.dart';

getProgress() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

mainContainer() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: dark_mode ? Colors.grey[200] : ColorsRes.grey,
  );
}

blurrDesing2(BuildContext context) {
  return isDrawerOpen
      ? Positioned.directional(
          textDirection: Directionality.of(context),
          top: height! * 0.0,
          start: width! * 0.75, // detail ma aya 0.50 htu
          child: Container(
            width: width! * 0.25,
            height: height,
            color: Colors.white.withOpacity(0.3),
          ),
        )
      : Container();
}

blurrDesing1(BuildContext context) {
  return isDrawerOpen
      ? Positioned.directional(
          textDirection: Directionality.of(context),
          top: height! * 0.0,
          start: width! * 0.50,
          child: Container(
            width: width! * 0.25,
            height: height,
            color: Colors.white.withOpacity(0.3),
          ),
        )
      : Container();
}

drawerHeading(BuildContext context, bool isRTL) {
  return Container(
    decoration: BoxDecoration(
      color: ColorsRes.textcolor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isRTL ? 30.0 : 0),
        topRight: Radius.circular(isRTL ? 0 : 30.0),
        bottomLeft: Radius.circular(isRTL ? 30.0 : 0),
        bottomRight: Radius.circular(isRTL ? 0 : 30.0),
      ),
    ),
    height: MediaQuery.of(context).size.height * 0.42,
    child: Stack(
      children: [
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: height! * 0.06,
          start: width! * 0.15,
          child: Image.asset(
            "assets/images/splash_logo.png",
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: height! * 0.34,
          start: width! * 0.18,
          child: Text(
            "FLUTTER OFFLINE",
            style: TextStyle(
                color: ColorsRes.appColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins-Bold"),
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: height! * 0.37,
          start: width! * 0.270,
          child: Text(
            "EBOOK APP",
            style: TextStyle(
              color: ColorsRes.appColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
