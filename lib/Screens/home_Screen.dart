import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/cart_Screen.dart';
import 'package:temp1/Screens/order_DetailsScreen.dart';
import 'package:temp1/Screens/product_DetailsScreen.dart';
import 'package:temp1/Screens/profile_DetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp1/utility/common_function.dart';

import 'info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool is_favourite = false;
  List index_arr = [];
  List unfavourite = [];
  List favourite = [];
  List image_url = [];
  List price = [];
  List favourite_list = [];
  String? doc_id_ = "";
  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    doc_id_ = prefs.getString('doc_id');
    return 1;
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var verticalDivider = Container(
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.width * 0.008,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return FutureBuilder(
        future: getSharedPrefs(),
        builder: (ctx, snapshot) {
          if (snapshot.data == 1) {
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromRGBO(136, 148, 110, 1),
                    toolbarHeight: MediaQuery.of(context).size.height * 0.08,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HelpSupport()));
                        },
                        child: const Icon(
                          Icons.info,
                          size: 32.0,
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("customers")
                                  .doc(doc_id_)
                                  .get()
                                  .then((value) => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    profile_Product(
                                                      name: value['name'],
                                                      phone_number:
                                                          value['Phone_number'],
                                                      address: value['address'],
                                                      doc_id_: doc_id_ ?? "",
                                                    ))),
                                      });
                            },
                            child: const Icon(
                              Icons.person,
                              size: 32.0,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("customers")
                                  .doc(doc_id_)
                                  .get()
                                  .then((value) => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    order_Screen(
                                                      name: value['name'],
                                                      phone_number:
                                                          value['Phone_number'],
                                                      address: value['address'],
                                                    ))),
                                      });

                              showToast("Order can placed with 5km radius ");
                            },
                            child: const Icon(
                              Icons.shopping_cart,
                              size: 32.0,
                            ),
                          )),
                    ],
                  ),
                  body: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.asset("assets/logo.jpeg"),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100))),
                      ),
                      title_Widget(context, ' ORDERS', true),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        // color: Colors.teal,
                        color: const Color.fromRGBO(226, 236, 214, 0.3),
                        child: Center(
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(doc_id_)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    'Loading',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                var document = snapshot.data;
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (document != null) {
                                    int noOfOrders =
                                        int.parse(document['count']);
                                    if (noOfOrders == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Add Food items to your cart and Order it now',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                        itemCount: noOfOrders,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext, index) {
                                          //remove
                                          String orderNumberStr =
                                              "order" + (index + 1).toString();
                                          print(orderNumberStr);
                                          String order =
                                              document[orderNumberStr];
                                          List orderDetails =
                                              order.split(",").toList();
                                          String date = orderDetails[
                                              orderDetails.length - 1];
                                          orderDetails.removeLast();
                                          date = orderDetails[
                                                  orderDetails.length - 1] +
                                              ", " +
                                              date;
                                          orderDetails.removeLast();
                                          String address = orderDetails[
                                              orderDetails.length - 1];
                                          orderDetails.removeLast();
                                          String totalAmount = orderDetails[
                                              orderDetails.length - 1];
                                          orderDetails.removeLast();
                                          String status = orderDetails[0];
                                          orderDetails.removeAt(0);
                                          String itemCount = orderDetails[0];
                                          orderDetails.removeAt(0);
                                          print(orderDetails);
                                          String item = "";
                                          for (int i = 0;
                                              i < orderDetails.length;
                                              i++) {
                                            if (i % 2 == 0) {
                                              item =
                                                  item + "," + orderDetails[i];
                                            } else {
                                              item =
                                                  item + " " + orderDetails[i];
                                            }
                                          }
                                          item = item.substring(1);
                                          print(item);
                                          var textStyle = TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500);
                                          var textStyle2 = TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold);
                                          return InkWell(
                                            onTap: () async {
                                              // SharedPreferences prefs =
                                              //     await SharedPreferences.getInstance();
                                              // prefs.setString('doc_id', doc_id ?? "");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          order_Details(
                                                            address: address,
                                                            price: totalAmount,
                                                            status: status,
                                                            // status: "2",
                                                            name: item,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  color: const Color.fromRGBO(
                                                      136, 148, 110, 1),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 10.0,
                                                            bottom: 8.0,
                                                            right: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            'Delivery to the $address ',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: textStyle2,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(item,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              style: textStyle),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                                'Count : $itemCount',
                                                                style:
                                                                    textStyle),
                                                            verticalDivider,
                                                            Text(
                                                              date,
                                                              style: textStyle,
                                                            ),
                                                            verticalDivider,
                                                            Text(totalAmount,
                                                                style:
                                                                    textStyle),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.004,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Info & order',
                                                                  style:
                                                                      textStyle2),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8.0),
                                                                child: InkWell(
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_forward,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 32,
                                                                  ),
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
                                          );
                                        });
                                  }
                                }
                                return Text(
                                  'Loading',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
                        ),
                      ),
                      title_Widget(context, " FAVOURITES", true),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        // color: Colors.teal,
                        color: const Color.fromRGBO(226, 236, 214, 0.3),
                        child: Center(
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(doc_id_)
                                  // .doc("aVXRid4fNrIbPXzUMMSX")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    'Loading',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                var document = snapshot.data;
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (document != null &&
                                      document['favourite'] != "") {
                                    var favourites = (document['favourite']
                                        .split(",")
                                        .toList());
                                    print(favourites);
                                    price.clear();
                                    image_url.clear();
                                    favourite_list.clear();
                                    for (int i = 1;
                                        i < favourites.length;
                                        i = i + 3) {
                                      print(i);
                                      price.add(favourites[i]);
                                    }
                                    for (int i = 2;
                                        i < favourites.length;
                                        i = i + 3) {
                                      print(i);
                                      image_url.add(favourites[i]);
                                    }
                                    for (int i = 0;
                                        i < favourites.length;
                                        i = i + 3) {
                                      print(i);
                                      favourite_list.add(favourites[i]);
                                    }

                                    print(image_url + price + favourite_list);
                                    return ListView.builder(
                                        itemCount: price.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: InkWell(
                                              onTap: () async {
                                                String caloies = '';
                                                String carbs = '';
                                                String dressing = '';
                                                String fats = '';
                                                String imageUrl = '';
                                                String ingredients = '';
                                                String name = '';
                                                String price = '';
                                                String protein = '';
                                                int indexInFirebase = 0;
                                                await FirebaseFirestore.instance
                                                    .collection("menu_list")
                                                    .get()
                                                    .then((QuerySnapshot
                                                            snapshot) =>
                                                        snapshot.docs.forEach(
                                                            (DocumentSnapshot) {
                                                          if (DocumentSnapshot
                                                                  .get(
                                                                      'name') ==
                                                              favourite_list[
                                                                  index]) {
                                                            indexInFirebase =
                                                                index;
                                                            caloies =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'calories');
                                                            carbs =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'carbs');
                                                            dressing =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'dressing');
                                                            fats =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'fats');
                                                            imageUrl =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'image_url');
                                                            ingredients =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'ingredients');
                                                            name =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'name');
                                                            price =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'price');
                                                            protein =
                                                                DocumentSnapshot
                                                                    .get(
                                                                        'protein');
                                                          }
                                                        }));
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            product_Details(
                                                              caloies: caloies,
                                                              carbs: carbs,
                                                              dressing:
                                                                  dressing,
                                                              fats: fats,
                                                              image_url:
                                                                  imageUrl,
                                                              ingredients:
                                                                  ingredients,
                                                              name: name,
                                                              price: price,
                                                              protein: protein,
                                                            )));
                                              },
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  color: const Color.fromRGBO(
                                                      226, 236, 214, 0.3),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    136,
                                                                    148,
                                                                    110,
                                                                    1),
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.12,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 16,
                                                                      top: 20),
                                                                  child: Text(
                                                                    favourite_list[
                                                                            index]
                                                                        .toUpperCase(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.026),
                                                                  ),
                                                                ),
                                                              ),
                                                              const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    size: 32,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            136,
                                                                            148,
                                                                            110,
                                                                            2),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.18,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  image_url[
                                                                      index]),
                                                        ),
                                                      ),
                                                      Align(
                                                        widthFactor: 4,
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 16.0),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.08,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Rs.',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          136,
                                                                          148,
                                                                          110,
                                                                          1),
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015),
                                                                ),
                                                                Text(
                                                                  price[index],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.019),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        widthFactor: 1.6,
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            String name = '';
                                                            favourite_list
                                                                .removeAt(
                                                                    index);
                                                            image_url.removeAt(
                                                                index);
                                                            price.removeAt(
                                                                index);
                                                            for (int i = 0;
                                                                i <
                                                                    favourite_list
                                                                        .length;
                                                                i++) {
                                                              name = name +
                                                                  "," +
                                                                  favourite_list[
                                                                      i] +
                                                                  "," +
                                                                  price[i] +
                                                                  "," +
                                                                  image_url[i];
                                                            }
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "customers")
                                                                .doc(doc_id_)
                                                                .update({
                                                              'favourite': name
                                                                      .isNotEmpty
                                                                  ? name
                                                                      .substring(
                                                                      1,
                                                                    )
                                                                  : name
                                                            });
                                                            setState(() {});
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 16.0),
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                radius: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                child: Icon(
                                                                  unfavourite.contains(
                                                                          index)
                                                                      ? Icons
                                                                          .favorite_outline_rounded
                                                                      : Icons
                                                                          .favorite,
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      136,
                                                                      148,
                                                                      110,
                                                                      1),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Add Food items to your favourite food items items to viewhere',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }
                                }

                                return Text(
                                  'Loading',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
                        ),
                      ),
                      title_Widget(context, "OTHER FOODS", false),
                      image_Widget(context, 2),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      )
                    ],
                  ))),
            );
          } else {
            return Container();
          }
        });
  }

  Container image_Widget(BuildContext context, int noOfElement) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      // color: Colors.teal,
      color: const Color.fromRGBO(226, 236, 214, 0.3),
      child: Center(
        child: StreamBuilder<Object>(
            stream:
                FirebaseFirestore.instance.collection('menu_list').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const Text('PLease Wait')
                  : ListView.builder(
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext, index) {
                        DocumentSnapshot products =
                            (snapshot.data! as QuerySnapshot).docs[index];
                        String name = products['name'];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () async {
                              DocumentSnapshot products =
                                  (snapshot.data! as QuerySnapshot).docs[index];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => product_Details(
                                        caloies: products['calories'],
                                        carbs: products['carbs'],
                                        dressing: products['dressing'],
                                        fats: products['fats'],
                                        image_url: products['image_url'],
                                        ingredients: products['ingredients'],
                                        name: products['name'],
                                        price: products['price'],
                                        protein: products['protein'],
                                      )));
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.7,
                                color: const Color.fromRGBO(226, 236, 214, 0.3),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(136, 148, 110, 1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, top: 20),
                                                child: Text(
                                                  name.toUpperCase(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.026),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 16),
                                                child: Icon(
                                                  Icons.favorite,
                                                  size: 32,
                                                  color: Color.fromRGBO(
                                                      136, 148, 110, 2),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        backgroundImage:
                                            NetworkImage(products['image_url']),
                                      ),
                                    ),
                                    Align(
                                      widthFactor: 4,
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Rs.',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromRGBO(
                                                        136, 148, 110, 1),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015),
                                              ),
                                              Text(
                                                products['price'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.019),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      widthFactor: 1.6,
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () async {
                                          if (!favourite_list
                                              .contains(products['name'])) {
                                            String update = '';
                                            for (int i = 0;
                                                i < favourite_list.length;
                                                i++) {
                                              update = update +
                                                  "," +
                                                  favourite_list[i] +
                                                  "," +
                                                  price[i] +
                                                  "," +
                                                  image_url[i];
                                            }
                                            DocumentSnapshot products =
                                                (snapshot.data!
                                                        as QuerySnapshot)
                                                    .docs[index];
                                            update = update +
                                                "," +
                                                products['name'] +
                                                "," +
                                                products['price'] +
                                                "," +
                                                products['image_url'];
                                            print("dsds" + update);
                                            await FirebaseFirestore.instance
                                                .collection("customers")
                                                .doc(doc_id_)
                                                .update({
                                              'favourite': update.substring(
                                                1,
                                              ),
                                            });
                                            setState(() {});
                                          }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              child: Icon(
                                                favourite_list.contains(
                                                        products['name'])
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_outline_rounded,
                                                color: const Color.fromRGBO(
                                                    136, 148, 110, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
            }),
      ),
    );
  }

  Padding title_Widget(BuildContext context, String title, bool otherFood) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 32.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
          child: Row(
            children: [
              otherFood
                  ? Text(
                      'MY',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(136, 148, 110, 1),
                      ),
                    )
                  : Container(),
              Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
