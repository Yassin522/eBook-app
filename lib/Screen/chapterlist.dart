import 'package:book/Helper/String.dart';
import 'package:book/Screen/facebookadd.dart';
import 'package:book/Screen/search.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorsRes.dart';
import '../Helper/Constant.dart';
import '../Model/detail.dart';
import '../databaseHelper/dbhelper.dart';
import '../localization/Demo_Localization.dart';
import '../widgets/Appbar.dart';
import '../widgets/common.dart';
import '../widgets/drawer.dart';
import '../widgets/languageButton.dart';
import 'TermFeed/About_Us.dart';
import 'TermFeed/Contact_Us.dart';
import 'TermFeed/Privacy_Policy.dart';
import 'TermFeed/Terms___Conditions.dart';
import 'bookmarklist.dart';
import 'chapterDetails.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatefulWidget {
  final int? id;
  final String? title;
  ChapterList({Key? key, this.id, this.title}) : super(key: key);
  ChapterList1 createState() => ChapterList1();
}

class ChapterList1 extends State<ChapterList> {
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  List<detail> item = [];
  List<detail> _notesForDisplay = [];
  Icon searchIcon = const Icon(Icons.search);
  // for indicator
  String? title;
  int? ccatid;
  bool typing = false;
  String? source, query;
  //search highlightText
  Widget _currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool firsttime = true;

  showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {},
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  update() {
    setState(
      () {},
    );
  }

  List<TextSpan> highlightOccurrences(source, query) {
    if (query == null || query.isEmpty) {
      return [TextSpan(text: source)];
    }

    var matches = <Match>[];
    for (final token in query.trim().toLowerCase().split(' ')) {
      matches.addAll(token.allMatches(source.toLowerCase()));
    }

    if (matches.isEmpty) {
      return [TextSpan(text: source)];
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;
    final List<TextSpan> children = [];
    for (final match in matches) {
      if (match.end <= lastMatchEnd) {
        // already matched -> ignore
      } else if (match.start <= lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(
              lastMatchEnd,
              match.end,
            ),
            style: const TextStyle(
              backgroundColor: Color(0xff9a0b0b),
              color: Colors.white,
            ),
          ),
        );
      } else if (match.start > lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(
              lastMatchEnd,
              match.start,
            ),
          ),
        );
        children.add(
          TextSpan(
            text: source.substring(
              match.start,
              match.end,
            ),
            style: const TextStyle(
              backgroundColor: Color(0xff9a0b0b),
              color: Colors.white,
            ),
          ),
        );
      }
      if (lastMatchEnd < match.end) {
        lastMatchEnd = match.end;
      }
    }
    if (lastMatchEnd < source.length) {
      children.add(
        TextSpan(
          text: source.substring(
            lastMatchEnd,
            source.length,
          ),
        ),
      );
    }
    return children;
  }

  @override
  void initState() {
    super.initState();
    getTitle();
    getIndicator();
    super.initState();
    setState(
      () {
        instance.getDetail(widget.id!).then(
          (value) {
            item.addAll(value);
            _notesForDisplay = item;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            mainContainer(),
            blurrDesing2(context),
            Container(
              decoration: BoxDecoration(
                color: ColorsRes.appColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Language_flag == "ar" ? 0 : 30.0),
                  bottomRight:
                      Radius.circular(Language_flag == "ar" ? 0 : 30.0),
                  topLeft: Radius.circular(Language_flag == "ar" ? 30.0 : 0),
                  bottomLeft: Radius.circular(Language_flag == "ar" ? 30.0 : 0),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  drawerHeading(context, Language_flag == "ar" ? true : false),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/mode_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Dark Mode"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              dark_mode == true
                                  ? Image.asset(
                                      "assets/images/toggle_light.png")
                                  : Image.asset(
                                      "assets/images/toggle_dark.png"),
                            ],
                          ),
                          onTap: () {
                            if (dark_mode == true) {
                              setState(
                                () {
                                  dark_mode = false;
                                  setDarkMode(dark_mode);
                                },
                              );
                            } else {
                              setState(
                                () {
                                  dark_mode = true;
                                  setDarkMode(dark_mode);
                                },
                              );
                            }
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/termscond_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Terms & Conditions"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Terms_Condition(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset(
                                  "assets/images/privacypolicy_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Privacy Policy"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Privacy_Policy(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/rateus_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Rate Us"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            LaunchReview.launch(
                              androidAppId: packageName,
                              iOSAppId: iosAppId,
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/share_app.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Share App"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(
                              () {
                                Share.share(
                                    'https://play.google.com/store/apps/details? id=$packageName');
                              },
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/contactus_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("Contact Us"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Contact_Us(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Image.asset("assets/images/aboutus_icon.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  DemoLocalization.of(context)
                                      .translate("About Us"),
                                  style: TextStyle(
                                    color: ColorsRes.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const About_Us(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(
                  isDrawerOpen ? -0.5 : 0,
                ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 60,
                    color: ColorsRes.appColor.withOpacity(0.5),
                    offset: const Offset(1, 3),
                  ),
                ],
                color: dark_mode ? ColorsRes.white : ColorsRes.black,
                borderRadius: BorderRadius.circular(
                  isDrawerOpen ? 40 : 0.0,
                ),
              ),
              duration: const Duration(milliseconds: 250),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //common appbar Container

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.7,
                        color: dark_mode
                            ? Colors.grey[100]
                            : ColorsRes.grey, //grey1
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),

                                color: dark_mode
                                    ? ColorsRes.white
                                    : ColorsRes.grey1, //grey1
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15.0,
                                      left: 5,
                                      right: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            isDrawerOpen
                                                ? IconButton(
                                                    icon: Image.asset(
                                                      "assets/images/menu_icon.png",
                                                    ),
                                                    onPressed: () {
                                                      xOffset = 0;
                                                      yOffset = 0;
                                                      scaleFactor = 1;
                                                      isDrawerOpen = false;
                                                      setState(
                                                        () {},
                                                      );
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: Image.asset(
                                                      "assets/images/menu_icon.png",
                                                    ),
                                                    onPressed: () {
                                                      setState(
                                                        () {
                                                          if (Language_flag ==
                                                              "ar") {
                                                            xOffset = width *
                                                                -0.5; // for X- axis
                                                            yOffset = height *
                                                                0.1; // for Y -axis
                                                            scaleFactor =
                                                                0.8; // size of home screen
                                                            isDrawerOpen = true;
                                                          } else {
                                                            xOffset = width *
                                                                0.8; // for X- axis
                                                            yOffset = height *
                                                                0.1; // for Y -axis
                                                            scaleFactor =
                                                                0.8; // size of home screen
                                                            isDrawerOpen = true;
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                            Text(
                                              DemoLocalization.of(context)
                                                  .translate("appName"),
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: ColorsRes.appColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Image.asset(
                                                "assets/images/search_icon.png",
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListSearch(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12.0,
                                            left: 12.0,
                                            right: 12.0,
                                          ),
                                          child: Text(
                                            () {
                                              if (Language_flag == "en") {
                                                return en_Title!;
                                              } else if (Language_flag ==
                                                  "hi") {
                                                return hi_Title!;
                                              } else if (Language_flag ==
                                                  "zh") {
                                                return zh_Title!;
                                              } else if (Language_flag ==
                                                  "es") {
                                                return es_Title!;
                                              } else if (Language_flag ==
                                                  "ar") {
                                                return ar_Title!;
                                              } else if (Language_flag ==
                                                  "ru") {
                                                return ru_Title!;
                                              } else if (Language_flag ==
                                                  "ja") {
                                                return ja_Title!;
                                              } else if (Language_flag ==
                                                  "de") {
                                                return de_Title!;
                                              } else {
                                                return en_Title!;
                                              }
                                            }(),
                                            style: TextStyle(
                                              color: ColorsRes.appColor,
                                              fontSize: 20.0,
                                              fontFamily: "Poppings-ExtraBold",
                                              fontWeight: FontWeight.bold,
                                              height: 1.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12.0,
                                            top: 8.0,
                                            right: 12.0,
                                          ),
                                          child: Text(
                                            DemoLocalization.of(context)
                                                    .translate("Written by") +
                                                " " +
                                                () {
                                                  if (Language_flag == "en") {
                                                    return Author_name;
                                                  } else if (Language_flag ==
                                                      "hi") {
                                                    return hi_Author_name;
                                                  } else if (Language_flag ==
                                                      "zh") {
                                                    return zh_Author_name;
                                                  } else if (Language_flag ==
                                                      "es") {
                                                    return es_Author_name;
                                                  } else if (Language_flag ==
                                                      "ar") {
                                                    return ar_Author_name;
                                                  } else if (Language_flag ==
                                                      "ru") {
                                                    return ru_Author_name;
                                                  } else if (Language_flag ==
                                                      "ja") {
                                                    return ja_Author_name;
                                                  } else if (Language_flag ==
                                                      "de") {
                                                    return de_Author_name;
                                                  } else {
                                                    return Author_name;
                                                  }
                                                }(),
                                            style: TextStyle(
                                              color: dark_mode
                                                  ? ColorsRes.appColor
                                                  : ColorsRes.white,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                          ),
                                          child: Text(
                                            "${chapter_total} " +
                                                DemoLocalization.of(context)
                                                    .translate("Chapters"),
                                            style: TextStyle(
                                                color: dark_mode
                                                    ? ColorsRes.appColor
                                                    : ColorsRes.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              //  height: 75,
                              top: height * 0.111,
                              start: width * 0.66,
                              //   textDirection: TextDirection.,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/images/book_container.png",
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: width * 0.261,
                                      height: height * 0.2,
                                      child: Center(
                                        child: Text(
                                          () {
                                            if (Language_flag == "en") {
                                              return en_Title!;
                                            } else if (Language_flag == "hi") {
                                              return hi_Title!;
                                            } else if (Language_flag == "zh") {
                                              return zh_Title!;
                                            } else if (Language_flag == "es") {
                                              return es_Title!;
                                            } else if (Language_flag == "ar") {
                                              return ar_Title!;
                                            } else if (Language_flag == "ru") {
                                              return ru_Title!;
                                            } else if (Language_flag == "ja") {
                                              return ja_Title!;
                                            } else if (Language_flag == "de") {
                                              return de_Title!;
                                            } else {
                                              return en_Title!;
                                            }
                                          }(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorsRes.appColor,
                                            height: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.directional(
                                textDirection: Directionality.of(context),
                                top: width * 0.54,
                                start: width * 0.02,
                                child: LanguageWidget(
                                  update: update,
                                  fromHome: false,
                                )),
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              top: width * 0.54,
                              start: width * 0.235,
                              child: GestureDetector(
                                //  onTap: () {},\
                                onTap: () {
                                  if (firsttime) {
                                    firsttime = false;
                                    FaceBookAdds().showInterstitialAd();
                                    //      AdmobService.showInterstitialAd();
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookmarkList(),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: height * 0.055,
                                  width: width * 0.20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorsRes.appColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 4,
                                        ),
                                        child: Image.asset(
                                          "assets/images/bookmark_selected.png",
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .translate("bookMark"),
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
                              ),
                            ),
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              top: width * 0.54,
                              start: width * 0.45,
                              child: GestureDetector(
                                onTap: () async {
                                  await getTitle();
                                  await getIndicator();
                                  setState(() {});
                                  if (ccatid == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorsRes.appColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        duration: const Duration(
                                          seconds: 2,
                                        ),
                                        content: Text(
                                          DemoLocalization.of(context)
                                              .translate("Indicator not set !"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: ColorsRes.white,
                                              fontFamily: 'Times new Roman'),
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (firsttime) {
                                      firsttime = false;
                                      FaceBookAdds().showInterstitialAd();
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            id1: ccatid,
                                            title: title,
                                          ),
                                        ),
                                      ).then(
                                        (value) {
                                          setState(
                                            () {
                                              xOffset = 0;
                                              yOffset = 0;
                                              scaleFactor = 1;
                                              isDrawerOpen = false;
                                            },
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: height * 0.055,
                                  width: width * 0.20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorsRes.appColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 4,
                                        ),
                                        child: ccatid == null
                                            ? Image.asset(
                                                "assets/images/pinned_unselected.png",
                                              )
                                            : Image.asset(
                                                "assets/images/pinned_selected.png",
                                              ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .translate("pinned"),
                                          style: TextStyle(
                                            color: ColorsRes.textcolor,
                                            fontSize: 8,
                                            fontFamily: "Popinns-ExtraLight",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //  height: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.61,
                        width: MediaQuery.of(context).size.width,
                        color: dark_mode
                            ? ColorsRes.white
                            : ColorsRes.grey1, //grey1
                        child: Stack(
                          children: [
                            FutureBuilder(
                              //Fetching all the chapters from the list using the istance of the DatabaseHelper class
                              future: instance.getDetail(widget.id!),
                              builder: (context, index) {
                                //Checking if we got data or not from the DB
                                return ListView.builder(
                                  itemCount: _notesForDisplay.length,
                                  itemBuilder: (context, index) {
                                    var item = _notesForDisplay[index++];

                                    Last_Chapter = _notesForDisplay.length;

                                    return GestureDetector(
                                      onTap: () {
                                        if (firsttime) {
                                          firsttime = false;
                                          FaceBookAdds().showInterstitialAd();
                                        } else {
                                          setState(() {
                                            book_notcomplete = true;
                                          });
                                          FaceBookAdds().showInterstitialAd();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                id1: item.Id,
                                                title: item.Chapter,
                                              ),
                                            ),
                                          ).then(
                                            (value) {
                                              setState(
                                                () {
                                                  xOffset = 0;
                                                  yOffset = 0;
                                                  scaleFactor = 1;
                                                  isDrawerOpen = false;
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Container(
                                          height: height * 0.16, //100
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              topLeft: Radius.circular(30.0),
                                            ),
                                            color: dark_mode
                                                ? ColorsRes.white
                                                : ColorsRes.grey1, //grey1
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 8.0,
                                                spreadRadius: -8,
                                                offset: Offset(1, -4),
                                                //offset: Offset(0.0, 1.0), //(x,y)
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20.0,
                                              right: 20.0,
                                              left: 20.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    (() {
                                                      if (query == null ||
                                                          query!.isEmpty) {
                                                        return Expanded(
                                                          child: Text(
                                                            () {
                                                              if (Language_flag ==
                                                                  "en") {
                                                                return item
                                                                    .Chapter!;
                                                              } else if (Language_flag ==
                                                                  "hi") {
                                                                return item
                                                                    .hi_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "zh") {
                                                                return item
                                                                    .zh_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "es") {
                                                                return item
                                                                    .es_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "ar") {
                                                                return item
                                                                    .ar_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "ru") {
                                                                return item
                                                                    .ru_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "ja") {
                                                                return item
                                                                    .ja_Chapter!;
                                                              } else if (Language_flag ==
                                                                  "de") {
                                                                return item
                                                                    .de_Chapter!;
                                                              } else {
                                                                return item
                                                                    .Chapter!;
                                                              }
                                                            }(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: ColorsRes
                                                                  .appColor,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text("$index.");
                                                      }
                                                    }()),

                                                    // highlightOccurrences(item.Title, query),
                                                    //Icon(Icons.ac_unit),

                                                    Image.asset(
                                                      "assets/images/chapter_icon.png",
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    () {
                                                      if (Language_flag ==
                                                          "en") {
                                                        return item
                                                            .Short_Description!;
                                                      } else if (Language_flag ==
                                                          "hi") {
                                                        return item
                                                            .hi_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "zh") {
                                                        return item
                                                            .zh_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "es") {
                                                        return item
                                                            .es_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "ar") {
                                                        return item
                                                            .ar_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "ru") {
                                                        return item
                                                            .ru_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "ja") {
                                                        return item
                                                            .ja_Short_Description!;
                                                      } else if (Language_flag ==
                                                          "de") {
                                                        return item
                                                            .de_Short_Description!;
                                                      } else {
                                                        return item
                                                            .Short_Description!;
                                                      }
                                                    }(),
                                                    //  "${item.Short_Description}",
                                                    style: TextStyle(
                                                      color: dark_mode
                                                          ? ColorsRes.appColor
                                                          : ColorsRes.white,
                                                      // fontFamily: "Poppins",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isDrawerOpen
                ? Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: height * 0.0,
                    start: width * 0.75,
                    child: Container(
                      width: width * 0.25,
                      height: height,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  )
                : Container(),
            isDrawerOpen
                ? Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: height * 0.1,
                    start: width * 0.8,
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          },
                        );
                      },
                      child: Container(
                        width: width * 0.195,
                        height: height * 0.79,
                        color: Colors.transparent,
                      ),
                    ),
                  )
                : Container(),
            _currentAd
          ],
        ),
      ),
    );
  }

  Future<String> getTitle() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    title = preferences.getString("Title");
    return title!;
  }

  Future<int> getIndicator() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    ccatid = preferences.getInt("In");
    return ccatid!;
  }

  setDarkMode(bool dark_mode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool("Dark_Mode", dark_mode);
  }
}
