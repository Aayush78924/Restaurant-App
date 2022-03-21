

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/otp_Screen.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({Key? key}) : super(key: key);

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  TextEditingController phone_Number_Str = new TextEditingController();
  TextEditingController name_Controller = new TextEditingController();
  TextEditingController address_Controller = new TextEditingController();
  String address_str = '';
  bool is_name = false;
  bool is_number = false;
  bool is_address = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  String doc_id = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset("assets/logo.jpeg"),
          ),
          Text(
            'Sign In to continue',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
            child: TextFormField(
              controller: name_Controller,
              onTap: () {
                is_number = false;
                is_name = true;
                is_address = false;
                setState(() {});
              },
              showCursor: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.person,
                  color:
                      is_name ? Color.fromRGBO(136, 148, 110, 1) : Colors.grey,
                ),
                hintText: 'Enter your Name',
                fillColor: Colors.indigo,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(136, 148, 110, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: TextFormField(
              controller: phone_Number_Str,
              onTap: () {
                is_number = true;
                is_name = false;
                is_address = false;
                setState(() {});
              },
              showCursor: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.phone_iphone_rounded,
                  color: is_number
                      ? Color.fromRGBO(136, 148, 110, 1)
                      : Colors.grey,
                ),
                hintText: 'Enter your Phone Number',
                fillColor: Colors.indigo,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(136, 148, 110, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: TextFormField(
              controller: address_Controller,
              onTap: () {
                is_number = false;
                is_name = false;
                is_address = true;
                setState(() {});
              },
              showCursor: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.location_on,
                  color: is_address
                      ? Color.fromRGBO(136, 148, 110, 1)
                      : Colors.grey,
                ),
                hintText: 'Enter your Address',
                fillColor: Colors.indigo,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(136, 148, 110, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print("+91 " + phone_Number_Str.text);
                  if (phone_Number_Str.text.length == 10 &&
                      name_Controller.text.length != 0 &&
                      address_Controller.text.length != 0) {
                    auth.verifyPhoneNumber(
                      phoneNumber: "+91 " + phone_Number_Str.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        await auth
                            .signInWithCredential(credential)
                            .then((value) {
                          prefs.setBool('login', true);
                          print("You are logged in successfully");
                        });
                        bool is_duplicate = await verifyData(
                            phone_Number_Str.text,
                            name_Controller.text,
                            address_Controller.text);
                        if (!is_duplicate) {
                          await uploadingData(phone_Number_Str.text,
                              name_Controller.text, address_Controller.text);
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        showdialog(
                            context, "Enter valid Phone Number to continue");
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        otpVisibility = true;
                        verificationID = verificationId;
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => otp_Screen(
                                verificationID,
                                phone_Number_Str.text,
                                name_Controller.text,
                                address_Controller.text)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }
                  if (name_Controller.text.length == 0) {
                    showdialog(context, "Name field is empty!!");
                  } else if (phone_Number_Str.text.length == 0) {
                    showdialog(context, "Phone Number field is empty!!");
                  } else if (address_Controller.text.length == 0) {
                    showdialog(context, "Address field is empty!!");
                  } else if (phone_Number_Str.text.length != 10) {
                    showdialog(context, "Phone Number should be 10 digit!!");
                  }
                  setState(() {});
                  //remove
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => otp_Screen(verificationID)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(136, 148, 110, 1),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Center(
                      child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              )),
        ],
      ),
    )));
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

  Future<dynamic> showdialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("${text}"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: Text('OK'))),
            )
          ],
        );
      },
    );
  }
}
