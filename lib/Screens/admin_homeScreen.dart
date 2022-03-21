import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/admin_AddnewProduct.dart';
import 'package:temp1/Screens/admin_orderDetailsScreen.dart';
import 'package:temp1/Screens/admin_productsDetailsScreen.dart';
import 'package:temp1/Screens/product_DetailsScreen.dart';

class admin_OrderScreen extends StatefulWidget {
  final bool return_;
  const admin_OrderScreen({this.return_ = false, Key? key}) : super(key: key);

  @override
  State<admin_OrderScreen> createState() => _admin_OrderScreenState();
}

class _admin_OrderScreenState extends State<admin_OrderScreen> {
  int count_of_menufood_in_FB = 0;
  bool order = true;
  @override
  Widget build(BuildContext context) {
    // bool order = widget.return_;
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
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
                color: Color.fromRGBO(136, 148, 110, 1),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => admin_AddnewProduct(
                                  count: count_of_menufood_in_FB.toString(),
                                )));
                      },
                      child: Icon(
                        Icons.add,
                        size: 32.0,
                      ),
                    )),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        order = true;
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => admin_OrderScreen(
                        //         // return_: true,
                        //         )));
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.34,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(136, 148, 110, 1),
                          ),
                          color: order
                              ? Color.fromRGBO(136, 148, 110, 1)
                              : Color.fromRGBO(136, 148, 110, 0.3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Orders'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        order = false;
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => admin_OrderScreen(
                        //         // return_: false,
                        //         )));
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.34,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(136, 148, 110, 1),
                          ),
                          // color: Color.fromRGBO(136, 148, 110, 1),
                          color: order
                              ? Color.fromRGBO(136, 148, 110, 0.3)
                              : Color.fromRGBO(136, 148, 110, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'menu'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              order
                  ? StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            children: [
                              SpinKitWave(
                                color: Color.fromRGBO(136, 148, 110, 1),
                                size: 60.0,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                'Loading',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }
                        var document = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (document != null) {
                            int reverse_int = ((snapshot.data! as QuerySnapshot)
                                    .docs
                                    .length) -
                                2;
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ((snapshot.data! as QuerySnapshot)
                                        .docs
                                        .length) -
                                    1,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext, index) {
                                  DocumentSnapshot products =
                                      (snapshot.data! as QuerySnapshot)
                                          .docs[reverse_int];
                                  reverse_int = reverse_int - 1;
                                  String date = products['date'];
                                  List date_list = date.split(",").toList();
                                  date = date_list[0];
                                  date_list.clear();
                                  date_list = date.split(" ").toList();
                                  return InkWell(
                                    onTap: () async {
                                      int selected_index =
                                          ((snapshot.data! as QuerySnapshot)
                                                  .docs
                                                  .length) -
                                              (2 + index);
                                      DocumentSnapshot products =
                                          (snapshot.data! as QuerySnapshot)
                                                  .docs[
                                              ((snapshot.data! as QuerySnapshot)
                                                      .docs
                                                      .length) -
                                                  (2 + index)];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  admin_OrderDetails_Screen(
                                                    address: products[
                                                        'customer_address'],
                                                    customer_name: products[
                                                        'customer_name'],
                                                    phone_number: products[
                                                            'customer_phone']
                                                        .toString(),
                                                    price: products['price']
                                                        .toString(),
                                                    order_status:
                                                        (products['status']-1)
                                                            .toString(),
                                                    details: products['details']
                                                        .toString(),
                                                    order_count:
                                                        products['order_count']
                                                            .toString(),
                                                    customer_id:
                                                        products['customer_id']
                                                            .toString(),
                                                    order_Index: selected_index
                                                        .toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    color: Colors.white24,
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.03),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          date_list[0],
                                                          style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          date_list[1]
                                                              .toString()
                                                              .substring(0, 2),
                                                          style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.07,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55,
                                                  color: Colors.white70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .baseline,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            title_widget_menu(
                                                                context,
                                                                " Price : "),
                                                            value_widget_menu(
                                                                context,
                                                                "RS ${products['price'].toString()}"),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .baseline,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            title_widget_menu(
                                                                context,
                                                                "Name : "),
                                                            value_widget_menu(
                                                                context,
                                                                "${products['customer_name'].toString()}"),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .baseline,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            title_widget_menu(
                                                                context,
                                                                "Items Count : "),
                                                            value_widget_menu(
                                                                context,
                                                                "${products['count'].toString()}"),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }

                        return Column(
                          children: [
                            SpinKitWave(
                              color: Color.fromRGBO(136, 148, 110, 1),
                              size: 60.0,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Loading',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      })
                  :
                  //menu

                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('menu_list')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            children: [
                              SpinKitWave(
                                color: Color.fromRGBO(136, 148, 110, 1),
                                size: 60.0,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                'Loading',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }
                        var document = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (document != null) {
                            count_of_menufood_in_FB =
                                (snapshot.data! as QuerySnapshot).docs.length +
                                    1;
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: (snapshot.data! as QuerySnapshot)
                                    .docs
                                    .length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext, index) {
                                  DocumentSnapshot products =
                                      (snapshot.data! as QuerySnapshot)
                                          .docs[index];
                                  return InkWell(
                                    onTap: () async {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    color: Colors.white24,
                                                    child: Image.network(
                                                      products['image_url'],
                                                      fit: BoxFit.fill,
                                                    )),
                                                InkWell(
                                                  onTap: () async {
                                                    print("asasasasas");
                                                    DocumentSnapshot products =
                                                        (snapshot.data!
                                                                as QuerySnapshot)
                                                            .docs[index];
                                                    String doc_id = '';
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("menu_list")
                                                        .get()
                                                        .then((QuerySnapshot
                                                                snapshot) =>
                                                            snapshot.docs.forEach(
                                                                (DocumentSnapshot) {
                                                              if (DocumentSnapshot
                                                                          .get(
                                                                              'name')
                                                                      .toString() ==
                                                                  products[
                                                                          'name']
                                                                      .toString()) {
                                                                doc_id =
                                                                    DocumentSnapshot
                                                                        .id;
                                                              }
                                                            }));
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString(
                                                        'product_doc_id',
                                                        doc_id);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                admin_Productdetails(
                                                                  count_no_of_foods_FB:
                                                                      count_of_menufood_in_FB
                                                                          .toString(),
                                                                  calories:
                                                                      products[
                                                                          'calories'],
                                                                  carbs: products[
                                                                      'carbs'],
                                                                  dressing:
                                                                      products[
                                                                          'dressing'],
                                                                  fats: products[
                                                                      'fats'],
                                                                  image_url:
                                                                      products[
                                                                          'image_url'],
                                                                  ingredients:
                                                                      products[
                                                                          'ingredients'],
                                                                  name: products[
                                                                      'name'],
                                                                  price: products[
                                                                      'price'],
                                                                  protein: products[
                                                                      'protein'],
                                                                  doc_id:
                                                                      doc_id,
                                                                )));
                                                  },
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.55,
                                                    color: Colors.white70,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .baseline,
                                                            textBaseline:
                                                                TextBaseline
                                                                    .alphabetic,
                                                            children: [
                                                              title_widget_menu(
                                                                  context,
                                                                  "Price : "),
                                                              value_widget_menu(
                                                                  context,
                                                                  "RS ${products['price'].toString()}"),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .baseline,
                                                            textBaseline:
                                                                TextBaseline
                                                                    .alphabetic,
                                                            children: [
                                                              title_widget_menu(
                                                                  context,
                                                                  "Name : "),
                                                              value_widget_menu(
                                                                  context,
                                                                  "${products['name'].toString().toUpperCase()}"),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .baseline,
                                                            textBaseline:
                                                                TextBaseline
                                                                    .alphabetic,
                                                            children: [
                                                              title_widget_menu(
                                                                  context,
                                                                  "Ingredients : "),
                                                              value_widget_menu(
                                                                  context,
                                                                  "${products['ingredients'].toString()}"),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }

                        return Column(
                          children: [
                            SpinKitWave(
                              color: Color.fromRGBO(136, 148, 110, 1),
                              size: 60.0,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Loading',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }

  Flexible value_widget_menu(BuildContext context, String title) {
    return Flexible(
      child: Text(
        title,
        maxLines: 2,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: MediaQuery.of(context).size.height * 0.02,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Text title_widget_menu(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.023,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text title_widget(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
