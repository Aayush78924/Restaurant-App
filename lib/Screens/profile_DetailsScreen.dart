import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/cart_Screen.dart';
import 'package:temp1/Screens/home_Screen.dart';

class profile_Product extends StatefulWidget {
  final String doc_id_;
  final String name;
  final String address;
  final String phone_number;
  const profile_Product(
      {required this.name,
      required this.doc_id_,
      required this.address,
      required this.phone_number,
      Key? key})
      : super(key: key);

  @override
  State<profile_Product> createState() => _profile_ProductState();
}

class _profile_ProductState extends State<profile_Product> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(136, 148, 110, 1),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              size: 32.0,
            ),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  color: Color.fromRGBO(136, 148, 110, 1),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.13,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(136, 148, 110, 1),
                      borderRadius: BorderRadius.all(Radius.circular(70)),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 32.0,
                    ),
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("customers")
                      .doc(widget.doc_id_)
                      .get()
                      .then((value) => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => order_Screen(
                                      name: value['name'],
                                      phone_number: value['Phone_number'],
                                      address: value['address'],
                                    ))),
                          });
                },
                child: Icon(
                  Icons.card_travel_outlined,
                  size: 32.0,
                ),
              )),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Color.fromRGBO(136, 148, 110, 1),
              ),
            ),
            Align(
              heightFactor: 2.5,
              alignment: Alignment.center,
              child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/profile.jpg"),
                  )),
            ),
            Align(
              heightFactor: 4.6,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      widget.phone_number,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                heightFactor: 25,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    'Address',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Align(
              heightFactor: 5.8,
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.address,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
