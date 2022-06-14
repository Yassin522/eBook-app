// import 'package:flutter/material.dart';
// import 'package:launch_review/launch_review.dart';
// import 'package:share/share.dart';
// import '../../Helper/ColorsRes.dart';
// import '../../Helper/Constant.dart';
// import '../../Helper/String.dart';
// import '../../Helper/session.dart';
// import '../../localization/Demo_Localization.dart';
// import '../Screen/TermFeed/About_Us.dart';
// import '../Screen/TermFeed/Contact_Us.dart';
// import '../Screen/TermFeed/Privacy_Policy.dart';
// import '../Screen/TermFeed/Terms___Conditions.dart';
// import 'common.dart';

// class DrawerWidget extends StatefulWidget {
//   final Function? update;
//   bool? isSArabic;

//   DrawerWidget({Key? key, this.update, this.isSArabic}) : super(key: key);

//   @override
//   _DrawerWidgetState createState() => _DrawerWidgetState();
// }

// class _DrawerWidgetState extends State<DrawerWidget> {
//   @override
//   void initState() {}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ColorsRes.appColor,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(widget.isSArabic! ? 0 : 30.0),
//           bottomRight: Radius.circular(widget.isSArabic! ? 0 : 30.0),
//           topLeft: Radius.circular(widget.isSArabic! ? 30.0 : 0),
//           bottomLeft: Radius.circular(widget.isSArabic! ? 30.0 : 0),
//         ),
//       ),
//       width: MediaQuery.of(context).size.width * 0.75,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           drawerHeading(context, widget.isSArabic! ? true : false),
//           Padding(
//             padding: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/mode_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context).translate("Dark Mode"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 50,
//                       ),
//                       dark_mode == true
//                           ? Image.asset("assets/images/toggle_light.png")
//                           : Image.asset("assets/images/toggle_dark.png"),
//                     ],
//                   ),
//                   onTap: () {
//                     if (dark_mode == true) {
//                       widget.update!;
//                       setState(
//                         () {
//                           dark_mode = false;
//                           setDarkMode(dark_mode);
//                         },
//                       );
//                       widget.update!;
//                     } else {
//                       widget.update!;
//                       setState(
//                         () {
//                           dark_mode = true;
//                           setDarkMode(dark_mode);
//                         },
//                       );
//                       widget.update!;
//                     }
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/termscond_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context)
//                               .translate("Terms & Conditions"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Terms_Condition(),
//                       ),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/privacypolicy_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context)
//                               .translate("Privacy Policy"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Privacy_Policy(),
//                       ),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/rateus_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context).translate("Rate Us"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     LaunchReview.launch(
//                       androidAppId: packageName,
//                       iOSAppId: iosAppId,
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/share_app.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context).translate("Share App"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     setState(
//                       () {
//                         Share.share(
//                             'https://play.google.com/store/apps/details? id=$packageName');
//                       },
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/contactus_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context).translate("Contact Us"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Contact_Us(),
//                       ),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Row(
//                     children: [
//                       Image.asset("assets/images/aboutus_icon.png"),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           DemoLocalization.of(context).translate("About Us"),
//                           style: TextStyle(
//                             color: ColorsRes.white,
//                             fontSize: 20,
//                             fontFamily: "Poppins",
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const About_Us(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
