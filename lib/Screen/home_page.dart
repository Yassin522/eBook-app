import 'dart:ui';
import 'package:book/Helper/String.dart';
import 'package:book/Screen/search.dart';
import 'package:book/databaseHelper/dbhelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorsRes.dart';
import '../Helper/Constant.dart';
import '../Helper/session.dart';
import '../Model/Category.dart';
import '../localization/Demo_Localization.dart';
import '../widgets/Appbar.dart';
import '../widgets/bookMarkButton.dart';
import '../widgets/common.dart';
import '../widgets/drawer.dart';
import '../widgets/languageButton.dart';
import 'TermFeed/About_Us.dart';
import 'TermFeed/Contact_Us.dart';
import 'TermFeed/Privacy_Policy.dart';
import 'TermFeed/Terms___Conditions.dart';
import 'admob_service.dart';
import 'chapterDetails.dart';
import 'chapterlist.dart';
import 'facebookadd.dart';

class Mainpage extends StatefulWidget {
  final int? id;
  const Mainpage({
    Key? key,
    this.id,
  }) : super(key: key);
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<Mainpage> {
  bool firsttime = true;
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();
  int? ccatid;
  String? title;
  var currentIndexPage = 0;
  final PageController controller = PageController(initialPage: 0);
  final key = GlobalKey<ScaffoldState>();
  final List<String> imgList = [
    "assets/images/slider_home.png",
    "assets/images/slider2_home.png",
    "assets/images/slider2_home.png",
  ];

  @override
  void initState() {
    FaceBookAdds().innitialize();
    FaceBookAdds().loadInterstitialAd();
    FaceBookAdds().loadRewardedVideoAd();
    getTitle();
    getIndicator();
    setState(
      () {
        super.initState();
      },
    );
  }

  update() {
    setState(
      () {}, // for update current class
    );
  }

//------------------------------------------------------------------------------
//=============================== Animated Container ==============================

  animatedContainer() {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(
          isDrawerOpen ? -0.5 : 0,
        ),
      decoration: BoxDecoration(
        color: dark_mode ? ColorsRes.white : ColorsRes.grey,
        boxShadow: [
          BoxShadow(
            blurRadius: 60,
            color: ColorsRes.appColor.withOpacity(0.5),
            offset: const Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      duration: const Duration(milliseconds: 250),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  if (Language_flag == "ar") {
                                    xOffset = width! * -0.5; // for X- axis
                                    yOffset = height! * 0.1; // for Y -axis
                                    scaleFactor = 0.8; // size of home screen
                                    isDrawerOpen = true;
                                  } else {
                                    xOffset = width! * 0.8; // for X- axis
                                    yOffset = height! * 0.1; // for Y -axis
                                    scaleFactor = 0.8; // size of home screen
                                    isDrawerOpen = true;
                                  }
                                },
                              );
                            },
                          ),
                    Text(
                      DemoLocalization.of(context).translate("appName"),
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
                            builder: (context) => ListSearch(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              getSliders(),
              const SizedBox(
                height: 10,
              ),
              threeButtons(),
              getBooks(),
            ],
          ),
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
//==================================== Sliders =================================
  getImage(String img) {
    return Positioned.fill(
      child: Image.asset(
        img,
        fit: BoxFit.fill,
      ),
    );
  }

  getCommandBotton(double topPossion, double leftPossition) {
    return Positioned(
      top: height! * topPossion,
      left: width! * leftPossition,
      child: ElevatedButton(
        onPressed: () {
          controller.jumpTo(height! * 0.5);
        },
        style: ElevatedButton.styleFrom(
          primary: ColorsRes.textcolor,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
        child: Text(
          DemoLocalization.of(context).translate("Explore Now"),
          style: TextStyle(
            color: ColorsRes.appColor,
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  getTextFields(
    double topPossion,
    double leftPossition,
    String type,
  ) {
    return Positioned(
      top: height! * topPossion,
      left: width! * leftPossition,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                DemoLocalization.of(context).translate("Explore"),
                style: TextStyle(
                  color: ColorsRes.textcolor,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                DemoLocalization.of(context).translate(type),
                style: TextStyle(
                  color: ColorsRes.textcolor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DemoLocalization.of(context).translate("Books"),
                style: TextStyle(
                  color: ColorsRes.textcolor,
                  fontSize: 15,
                  fontFamily: "Poppins-Thin",
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getSliders() {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
        autoPlay: true,
        aspectRatio: 16 / 9,
      ),
      items: [
        Stack(
          children: [
            getImage("assets/images/slider_home.png"),
            getTextFields(0.030, 0.32, "Instructive"),
            getCommandBotton(0.16, 0.45),
          ],
        ),
        Stack(
          children: [
            getImage("assets/images/slider2_home.png"),
            getTextFields(0.030, 0.32, "Biography"),
            getCommandBotton(0.16, 0.45),
          ],
        ),
        Stack(
          children: [
            getImage("assets/images/slider2_home.png"),
            getTextFields(0.030, 0.32, "Historical"),
            getCommandBotton(0.16, 0.45),
          ],
        ),
      ],
    );
  }

//------------------------------------------------------------------------------
//=============================== 3 Buttons ==============================

  threeButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LanguageWidget(
            update: update,
            fromHome: true,
          ),
          BookMarkButton(
            update: update,
            fromHome: true,
          ),
          getThirdButton(),
        ],
      ),
    );
  }

  // Third Button
  getThirdButton() {
    return InkWell(
      onTap: () async {
        await getTitle();
        await getIndicator();
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
                DemoLocalization.of(context).translate("Indicator not set !"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorsRes.white,
                  fontFamily: 'Times new Roman',
                ),
              ),
            ),
          );
        } else {
          if (firsttime) {
            firsttime = false;
            FaceBookAdds().showInterstitialAd();
            //      AdmobService.showInterstitialAd();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  id1: ccatid,
                  title: title,
                ),
              ),
            );
          }
        }
      },
      child: Container(
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
            ccatid == null
                ? Image.asset(
                    "assets/images/pinned_unselected.png",
                  )
                : Image.asset(
                    "assets/images/pinned_selected.png",
                  ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  DemoLocalization.of(context).translate("pinned"),
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
      ),
    );
  }

//------------------------------------------------------------------------------
//=============================== 3 Buttons ====================================
  getBooks() {
    return Container(
      margin: const EdgeInsets.all(15),
      color: dark_mode ? ColorsRes.white : ColorsRes.grey,
      child: FutureBuilder(
        //Fetching all the persons from the list using the istance of the DatabaseHelper class
        future: instance.getCategory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Checking if we got data or not from the DB
          if (snapshot.hasData) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.965,
              ),
              itemBuilder: (BuildContext context, int index) {
                Category item = snapshot.data[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // data base to global variable title
                        en_Title = item.Title;
                        zh_Title = item.zh_Title;
                        hi_Title = item.hi_Title;
                        ru_Title = item.ru_Title;
                        ar_Title = item.ar_Title;
                        es_Title = item.es_Title;
                        de_Title = item.de_Title;
                        ja_Title = item.ja_Title;
                        // data base to global variable Author
                        Author_name = item.Author!;
                        zh_Author_name = item.zh_Author!;
                        hi_Author_name = item.hi_Author!;
                        ru_Author_name = item.ru_Author!;
                        ar_Author_name = item.ar_Author!;
                        es_Author_name = item.es_Author!;
                        de_Author_name = item.de_Author!;
                        ja_Author_name = item.ja_Author!;
                        // data base to global variable For Chapter Count
                        chapter_total = item.Chapter;
                        //       AdmobService.showInterstitialAd();
                        //AdmobService().showInterstitialAd();
                        AdmobService().createRewardedAd();
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChapterList(
                                id: item.Id,
                                title: item.Title,
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
                                  initState();
                                },
                              );
                            },
                          );
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/container_box.png",
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  () {
                                    if (Language_flag == "en") {
                                      return item.Title!;
                                    } else if (Language_flag == "hi") {
                                      return item.hi_Title!;
                                    } else if (Language_flag == "zh") {
                                      return item.zh_Title!;
                                    } else if (Language_flag == "es") {
                                      return item.es_Title!;
                                    } else if (Language_flag == "ar") {
                                      return item.ar_Title!;
                                    } else if (Language_flag == "ru") {
                                      return item.ru_Title!;
                                    } else if (Language_flag == "ja") {
                                      return item.ja_Title!;
                                    } else if (Language_flag == "de") {
                                      return item.de_Title!;
                                    } else {
                                      return item.Title!;
                                    }
                                  }(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorsRes.appColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return getProgress();
          }
        },
      ),
    );
  }

//------------------------------------------------------------------------------
//=============================== Build Method ==============================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: key,
      backgroundColor: dark_mode ? Colors.grey[200] : ColorsRes.grey,
      body: SafeArea(
        child: Stack(
          children: [
            mainContainer(),
            blurrDesing1(context),
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
            animatedContainer(),
            blurrDesing2(context),
            isDrawerOpen
                ? Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: height! * 0.1,
                    start: width! * 0.8,
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
                        width: width! * 0.195,
                        height: height! * 0.79,
                        color: Colors.transparent,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
//=============================== Shared Preferance ==============================

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
}
