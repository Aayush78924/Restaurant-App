import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var greenx = const Color.fromRGBO(136, 148, 110, 1);
showToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

myText(String content,
    {
    // String fontfamily = PRIMARY_FONT,
    double size = 20,
    int maxLine = 3,
    Color? color = Colors.white,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    content,
    overflow: TextOverflow.fade,
    maxLines: maxLine,
    //maxLines: 3,
    style: TextStyle(
      // fontFamily: fontfamily,
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

blueButton(
  BuildContext context, {
  String? title,
  Color? buttonColor,
  Function? function,
  double height = 20,
  double width = 20,
  double tsize = 60,
  Color? textColor,
}) {
  textColor = textColor ?? Colors.white;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: buttonColor),
      child: Center(
        child: myText(title.toString(), color: textColor, size: tsize),
      ),
    ),
  );
}

class Mq {
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
