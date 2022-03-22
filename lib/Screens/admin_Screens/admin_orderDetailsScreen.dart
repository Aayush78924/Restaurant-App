import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp1/Screens/admin_Screens/admin_homeScreen.dart';

class admin_OrderDetails_Screen extends StatefulWidget {
  final String address;
  final String customer_name;
  final String phone_number;
  final String price;
  final String order_status;
  final String details;
  final String order_count;
  final String customer_id;
  final String order_Index;
  admin_OrderDetails_Screen(
      {required this.address,
      required this.customer_name,
      required this.phone_number,
      required this.price,
      required this.order_status,
      required this.details,
      required this.order_count,
      required this.customer_id,
      required this.order_Index,
      Key? key})
      : super(key: key);

  @override
  State<admin_OrderDetails_Screen> createState() =>
      _admin_OrderDetails_ScreenState();
}

class _admin_OrderDetails_ScreenState extends State<admin_OrderDetails_Screen> {
  int no_of_orders = 0;
  double _value = 0;
  bool slider_change = false;
  @override
  Widget build(BuildContext context) {
    no_of_orders = 0;
    List details = widget.details.toString().split(",").toList();
    print(details);
    for (int i = 0; i < details.length; i = i + 1) {
      if (details[i] == "length") {
        no_of_orders = no_of_orders + 1;
      }
    }
    print("sdsd");
    print(no_of_orders);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(136, 148, 110, 1),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Text(
          'health_do'.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => admin_OrderScreen()));
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Order Information',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color.fromRGBO(136, 148, 110, 1), width: 1.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_city_outlined),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Flexible(
                                child: Text(
                                  widget.address,
                                  // 'asas',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Flexible(
                                child: Text(
                                  widget.customer_name,
                                  // 'ssasa',
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Text(
                                widget.phone_number,
                                // 'asa',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Text(
                                'Rs ${widget.price}',
                                // "23",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //orderStatus
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color.fromRGBO(136, 148, 110, 1), width: 1.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'Order Status',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Slider(
                          onChanged: (value) {},
                          activeColor: Color.fromRGBO(136, 148, 110, 1),
                          inactiveColor: Color.fromRGBO(136, 148, 110, 0.4),
                          thumbColor: Color.fromRGBO(136, 148, 110, 1),
                          min: 0.0,
                          max: 100.0,
                          value: slider_change
                              ? _value
                              : (double.parse(widget.order_status)) * 30.0,
                          divisions: 3,
                          onChangeEnd: (value) async {
                            setState(() {});
                            print("hello");
                            String cart = "";
                            int status = 0;
                            if (value > 67) {
                              status = 4;
                            } else if (value > 34) {
                              status = 3;
                            } else if (value > 10) {
                              status = 2;
                            } else {
                              status = 1;
                            }
                            slider_change = true;
                            _value = value;
                            await FirebaseFirestore.instance
                                .collection("customers")
                                .doc(widget.customer_id)
                                .get()
                                .then((value) {
                              cart = value['order${widget.order_count}'];
                            });
                            cart = cart.substring(1);
                            cart = status.toString() + cart;
                            print(cart);
                            print(widget.customer_id);
                            print(widget.order_count);
                            await FirebaseFirestore.instance
                                .collection("customers")
                                .doc(widget.customer_id)
                                .update({
                              'order${widget.order_count}': cart.toString()
                            });
                            await FirebaseFirestore.instance
                                .collection("orders")
                                .doc("Order_${widget.order_Index}")
                                .update({'status': status.toString()});
                          },
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
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
                ),
              ),
            ),

            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: no_of_orders,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext, index) {
                  int j = 0;
                  String name = "";
                  String count = "";
                  int ingredients_length = 0;
                  List Ingredient = [];
                  for (int i = 0; i < details.length; i = i + 1) {
                    if (details[i] == "length") {
                      name = details[i - 3];
                      count = details[i - 1];
                      ingredients_length = int.parse(details[i + 1]);
                      print(ingredients_length);
                      for (int j = 0; j < ingredients_length; j++) {
                        Ingredient.add(details[i + j + 2]);
                      }
                      details[i] = "-1";
                      break;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color.fromRGBO(136, 148, 110, 1),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 16.0,
                                    bottom: 16.0,
                                    right: 8.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'Name : ',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${name.toUpperCase()} ( $count )',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'Ingredients : ',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Flexible(
                                      child: Text(
                                        Ingredient.join(", "),
                                        style: TextStyle(
                                          overflow: TextOverflow.visible,
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

            //menu
          ],
        ),
      ),
    ));
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
