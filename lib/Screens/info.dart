import 'package:flutter/material.dart';
import 'package:temp1/utility/common_function.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: Mq.width(context) * 0.02, right: Mq.width(context) * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Mq.height(context) * 0.3,
            ),
            Padding(
              padding: EdgeInsets.only(top: Mq.height(context) * 0.0003),
              child: myText("Health do",
                  size: Mq.height(context) * 0.032,
                  fontWeight: FontWeight.w600,
                  color: greenx),
            ),
            Padding(
              padding: EdgeInsets.only(top: Mq.height(context) * 0.02),
              child: myText(
                "Corporate Head Office",
                size: Mq.height(context) * 0.017,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline1?.color,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Mq.height(context) * 0.005,
                  bottom: Mq.height(context) * 0.005),
              child: myText(
                "190, nigam nagar, Phase 9, Sector 3, orissa,\nIndia, 985678",
                size: Mq.height(context) * 0.016,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.subtitle1?.color,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Mq.height(context) * 0.02),
              child: Container(
                height: MediaQuery.of(context).size.height / 12.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: greenx,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: ClipPath(
                    clipper: const ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Padding(
                      padding: EdgeInsets.only(top: Mq.height(context) * 0.01),
                      child: const Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  title: Text(
                    "Contact Us",
                    style: TextStyle(
                        fontSize: Mq.height(context) * 0.017,
                        color: Theme.of(context).textTheme.subtitle1?.color,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    '0806767717',
                    style: TextStyle(
                        fontSize: Mq.height(context) * 0.016,
                        color: Theme.of(context).textTheme.headline1?.color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 12.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: greenx,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: ListTile(
                leading: ClipPath(
                  clipper: const ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: Padding(
                    padding: EdgeInsets.only(top: Mq.height(context) * 0.01),
                    child: const Icon(
                      Icons.email,
                    ),
                  ),
                ),
                title: Text(
                  "Mail Us",
                  style: TextStyle(
                      fontSize: Mq.height(context) * 0.017,
                      color: Theme.of(context).textTheme.subtitle1?.color,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  'support@healthdo.in',
                  style: TextStyle(
                      fontSize: Mq.height(context) * 0.016,
                      color: Theme.of(context).textTheme.headline1?.color,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(Mq.height(context) * 0.02),
                  child: GestureDetector(
                    child: Container(
                      child: blueButton(context,
                          title: "Chat with our Support",
                          tsize: Mq.height(context) * 0.025,
                          height: Mq.height(context) * 0.075,
                          width: Mq.width(context),
                          function: () {},
                          buttonColor: greenx),
                    ),
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
