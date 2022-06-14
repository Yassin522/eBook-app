import 'package:book/Helper/String.dart';
import 'package:flutter/material.dart';
import '../../Helper/ColorsRes.dart';
import '../../localization/Demo_Localization.dart';
import '../Screen/search.dart';

class CustomAppbar extends StatefulWidget {
  final Function? update;

  CustomAppbar({
    Key? key,
    this.update,
  }) : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isDrawerOpen
            ? IconButton(
                icon: Image.asset(
                  "assets/images/menu_icon.png",
                ),
                onPressed: () {
                  widget.update!;
                  xOffset = 0;
                  yOffset = 0;
                  scaleFactor = 1;
                  isDrawerOpen = false;
                  setState(
                    () {},
                  );
                  widget.update!;
                },
              )
            : IconButton(
                icon: Image.asset(
                  "assets/images/menu_icon.png",
                ),
                onPressed: () {
                  widget.update!;
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
                  widget.update!;
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
    );
  }
}
