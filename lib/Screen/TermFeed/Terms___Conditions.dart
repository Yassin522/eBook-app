import 'package:flutter/material.dart';

import '../../Helper/ColorsRes.dart';
import '../../Helper/String.dart';
import '../../localization/Demo_Localization.dart';

class Terms_Condition extends StatefulWidget {
  const Terms_Condition({Key? key}) : super(key: key);

  @override
  _Terms_ConditionState createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark_mode ? ColorsRes.white : ColorsRes.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          DemoLocalization.of(context).translate("Terms & Conditions"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
          ),
          child: RichText(
            text: TextSpan(
              style:  TextStyle(
                fontSize: 16.0,
                color: dark_mode ? ColorsRes.black : Colors.white,
              ),
              children: <TextSpan>[
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "Lorem Ipsum ",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n \n \n",
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "Lorem Ipsum ",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n \n \n",
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "Lorem Ipsum ",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n \n \n",
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "Lorem Ipsum ",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n \n \n",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
