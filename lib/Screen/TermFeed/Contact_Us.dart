import 'package:flutter/material.dart';
import '../../Helper/ColorsRes.dart';
import '../../Helper/String.dart';
import '../../localization/Demo_Localization.dart';

class Contact_Us extends StatefulWidget {
  const Contact_Us({Key? key}) : super(key: key);

  @override
  _Contact_UsState createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark_mode ? ColorsRes.white : ColorsRes.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(DemoLocalization.of(context).translate("Contact Us")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
          ),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style:  TextStyle(
                fontSize: 16.0,
                color: dark_mode ? ColorsRes.black : Colors.white,
              ),
              children: <TextSpan>[
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "For any kind of queries related to products please contact us. \n  \n",
                  ),
             
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "To help our ",
                  ),
              
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "Customers",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    ", we constantly be in touch with every customer if they need any assistance regarding our product. We offer our customers support from Mon – Fri 9.00am to 6.00pm IST (GMT +5.30) – We are a company located in India – Asia.Typically we reply to our customers for all the questions and queries within 24 hours of time via comments, support forums, or emails. ",
                  ),
                ),
                 TextSpan(
                  text: DemoLocalization.of(context).translate(
                    "\n \nThank You...",
                  ),
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
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
