import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/login_Screen.dart';

class otp_Screen extends StatefulWidget {
  final String verificationid;
  final String phone_Number;
  final String name;
  final String address;
  const otp_Screen(
      this.verificationid, this.phone_Number, this.name, this.address,
      {Key? key})
      : super(key: key);

  @override
  State<otp_Screen> createState() => _otp_ScreenState();
}

class _otp_ScreenState extends State<otp_Screen> {
  String otp = '';
  String doc_id = "";
  bool otp_verified = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.jpeg"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Enter the OTP sent to ${widget.phone_Number}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 4,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        _otpTextField(context, true),
                        _otpTextField(context, false),
                        _otpTextField(context, false),
                        _otpTextField(context, false),
                        _otpTextField(context, false),
                        _otpTextField(context, false),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: InkWell(
                        onTap: () async {
                          print(otp.length);
                          if (otp.length == 6) {
                            bool ver = false;
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: widget.verificationid,
                                    smsCode: otp);
                            otp_verified = true;
                            await auth
                                .signInWithCredential(credential)
                                .then((value) {
                              ver = true;
                            });
                            if (ver) {
                              print(" V E R I F I E D ");
                              bool is_duplicate = await verifyData(
                                  widget.phone_Number,
                                  widget.name,
                                  widget.address);
                              if (!is_duplicate) {
                                await uploadingData(widget.phone_Number,
                                    widget.name, widget.address);
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(136, 148, 110, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Verify & Proceed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: otp_verified,
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Something went wrong try again.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 32.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => login_Screen()));
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _otpTextField(BuildContext context, bool autoFocus) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 3.0,
            color: Color.fromRGBO(136, 148, 110, 1),
          ),
        ),
        color: Colors.white,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: autoFocus,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          maxLines: 1,
          onChanged: (value) {
            otp = otp + value;
            if (value.length == 1) {
              print(otp);
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }

  Future<void> uploadingData(
      String Phone_number, String name, String address) async {
    await FirebaseFirestore.instance.collection("customers").add({
      'Phone_number': Phone_number,
      'name': name,
      'address': address,
      'favourite': "",
      'cart': "",
      'count': "0",
    });
    await FirebaseFirestore.instance.collection("customers").get().then(
        (QuerySnapshot snapshot) => snapshot.docs.forEach((DocumentSnapshot) {
              if (DocumentSnapshot.get('Phone_number') == Phone_number) {
                doc_id = DocumentSnapshot.id;
              }
            }));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    prefs.setString('doc_id', doc_id);
  }

  Future<bool> verifyData(
      String Phone_number, String name, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool duplicate = false;
    await FirebaseFirestore.instance.collection("customers").get().then(
        (QuerySnapshot snapshot) => snapshot.docs.forEach((DocumentSnapshot) {
              if (DocumentSnapshot.get('Phone_number') == Phone_number) {
                duplicate = true;
                doc_id = DocumentSnapshot.id;
                prefs.setString('doc_id', doc_id);
              }
            }));
    if (duplicate) {
      await FirebaseFirestore.instance
          .collection("customers")
          .doc(doc_id)
          .update({'name': name, 'address': address});
      prefs.setString('doc_id', doc_id);
      prefs.setBool('login', true);
    }
    return duplicate;
  }
}
