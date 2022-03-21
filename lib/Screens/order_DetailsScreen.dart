import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/profile_DetailsScreen.dart';

class order_Details extends StatefulWidget {
  final String address;
  final String name;
  final String status;
  final String price;
  const order_Details(
      {required this.address,
      required this.name,
      required this.status,
      required this.price,
      Key? key})
      : super(key: key);

  @override
  State<order_Details> createState() => _order_DetailsState();
}

class _order_DetailsState extends State<order_Details> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    String order_status = "";
    double order_Status_Slider = 0.0;
    if (widget.status == "1") {
      order_Status_Slider = 0;
      order_status = "Received";
    }
    if (widget.status == "2") {
      order_Status_Slider = 30.0;
      order_status = "Preparing";
    }
    if (widget.status == "3") {
      order_Status_Slider = 60.0;
      order_status = "Ready";
    }
    if (widget.status == "4") {
      order_Status_Slider = 90.0;
      order_status = "Delivery";
    }
    List ingredients = widget.name.split(",").toList();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(136, 148, 110, 1),
              toolbarHeight: MediaQuery.of(context).size.height * 0.08,
              leading: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 32.0,
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: Color.fromRGBO(136, 148, 110, 0.3),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Row(
                          children: [
                            Text(
                              'Order Status   :    ',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              order_status,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Total Amount : ',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.032,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Rs ${widget.price}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Slider(
                          activeColor: Color.fromRGBO(136, 148, 110, 1),
                          inactiveColor: Color.fromRGBO(136, 148, 110, 0.4),
                          thumbColor: Color.fromRGBO(136, 148, 110, 1),
                          min: 0.0,
                          max: 100.0,
                          value: (order_Status_Slider),
                          divisions: 3,
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            status_updater("Received"),
                            status_updater("Preparing"),
                            status_updater("Ready"),
                            status_updater("Delivery"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          'Items',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: ingredients.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 64.0, top: 16.0, bottom: 16.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  //color: Color.fromRGBO(136, 148, 110, 1),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                        backgroundColor:
                                            Color.fromRGBO(136, 148, 110, 1),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${ingredients[index]}',
                                          style: TextStyle(
                                              overflow: TextOverflow.visible,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  color: Color.fromRGBO(136, 148, 110, 1),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset("assets/delivery_man.png",
                                  width: 100, fit: BoxFit.fill),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.address,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ]),
                )
              ],
            )));
  }

  Card status_updater(String text) {
    return Card(
      color: Color.fromRGBO(136, 148, 110, 1),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${text}',
        ),
      ),
    );
  }
}
