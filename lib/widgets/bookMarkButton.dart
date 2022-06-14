import 'package:flutter/material.dart';
import '../../Helper/ColorsRes.dart';
import '../../localization/Demo_Localization.dart';
import '../Screen/bookmarklist.dart';

class BookMarkButton extends StatefulWidget {
  final Function? update;
  bool? fromHome;

  BookMarkButton({Key? key, this.update, this.fromHome}) : super(key: key);

  @override
  _BookMarkButtonState createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //   AdmobService.showInterstitialAd();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookmarkList(),
          ),
        ).then(
          (value) {
            setState(
              () {},
            );
          },
        );
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
            Image.asset(
              "assets/images/bookmark_selected.png",
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  DemoLocalization.of(context).translate("bookMark"),
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
}
