import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/profile_DetailsScreen.dart';

class order_Screen extends StatefulWidget {
  final String name;
  final String address;
  final String phone_number;
  const order_Screen(
      {required this.name,
      required this.address,
      required this.phone_number,
      Key? key})
      : super(key: key);

  @override
  State<order_Screen> createState() => _order_ScreenState();
}

class _order_ScreenState extends State<order_Screen> {
  List count = [];
  bool loading = false;
  List price = [];
  List name = [];
  String cart = "";
  String? doc_id_ = "";
  bool cart_empty = false;
  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    doc_id_ = prefs.getString('doc_id');
    await FirebaseFirestore.instance
        .collection("customers")
        .doc(doc_id_)
        .get()
        .then((value) => {
              if (value['cart'] == "") {cart_empty = true}
            });
    return 1;
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSharedPrefs(),
        builder: (ctx, snapshot) {
          if (snapshot.data == 1) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(136, 148, 110, 1),
                  toolbarHeight: MediaQuery.of(context).size.height * 0.08,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
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
                          child: Icon(
                            Icons.person,
                            size: 32.0,
                          ),
                        )),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70)),
                              ),
                              child: Icon(
                                Icons.card_travel_outlined,
                                size: 32.0,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'My Cart',
                              style: TextStyle(
                                color: Color.fromRGBO(136, 148, 110, 1),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(doc_id_)
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
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      Text(
                                        'Loading',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                    if (document['cart'] == "") {
                                      return Padding(
                                        padding: const EdgeInsets.all(24.0),
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
                                    } else {
                                      cart = document['cart'];
                                      cart = cart.substring(1);
                                      List favourites_list =
                                          (cart.split(",").toList());
                                      price.clear();
                                      name.clear();
                                      List image_url = [];
                                      List filter_fav = [];
                                      int j = 0;
                                      print(favourites_list);
                                      print(favourites_list[0]);
                                      for (int i = 0;
                                          i < favourites_list.length;
                                          i = i + j) {
                                        print(i);
                                        j = 0;
                                        if (favourites_list[i] == "length") {
                                          j = int.parse(
                                                  favourites_list[i + 1]) +
                                              2;
                                        } else {
                                          filter_fav.add(favourites_list[i]);
                                          j = 1;
                                        }
                                      }
                                      for (int i = 0;
                                          i < filter_fav.length;
                                          i = i + 4) {
                                        image_url.add(filter_fav[i]);
                                        name.add(filter_fav[i + 1]);
                                        price.add(filter_fav[i + 2]);
                                        count.add(filter_fav[i + 3]);
                                      }
                                      print(filter_fav);
                                      print(image_url);
                                      print(name);
                                      print(price);
                                      print(count);
                                      return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: image_url.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext, index) {
                                            // Future.delayed(Duration.zero, () async {
                                            //   setState(() {});
                                            // });
                                            return InkWell(
                                              onTap: () async {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
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
                                                              0.7,
                                                      color: Color.fromRGBO(
                                                          136, 148, 110, 1),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              height: MediaQuery
                                                                          .of(
                                                                              context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.35,
                                                              child:
                                                                  Image.network(
                                                                image_url[
                                                                    index],
                                                                fit:
                                                                    BoxFit.fill,
                                                              )),
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.15,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                            color:
                                                                Colors.white70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
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
                                                                      Text(
                                                                        "Rs : ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.03,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        price[
                                                                            index],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height * 0.025,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      name[index]
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style:
                                                                          TextStyle(
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.017,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  count_Widget_(
                                                                      index,
                                                                      context),
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
                                }
                                return Column(
                                  children: [
                                    SpinKitWave(
                                      color: Color.fromRGBO(136, 148, 110, 1),
                                      size: 60.0,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Text(
                                      'Loading',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          cart_empty
                              ? Container()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    color: Color.fromRGBO(136, 148, 110, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () async {
                                        List favourites_list =
                                            (cart.split(",").toList());
                                        int j = 0;
                                        for (int i = 0;
                                            i < favourites_list.length;
                                            i++) {
                                          if (favourites_list[i] == "length") {
                                            favourites_list[i - 1] = count[j];
                                            j = j + 1;
                                          }
                                        }
                                        String order_admin =
                                            favourites_list.join(",");
                                        print(order_admin);
                                        String count_order = "";
                                        int total_number_of_items = 0;
                                        for (int i = 0; i < name.length; i++) {
                                          total_number_of_items =
                                              total_number_of_items +
                                                  int.parse(count[i]);
                                        }
                                        String cart_customer =
                                            "1,${total_number_of_items}";
                                        int price_int = 0;
                                        print(count);
                                        for (int i = 0; i < name.length; i++) {
                                          cart_customer = cart_customer +
                                              "," +
                                              count[i] +
                                              "," +
                                              name[i];
                                          int price_Arr = int.parse(price[i]);
                                          int count_arr = int.parse(count[i]);
                                          price_int = price_int +
                                              (price_Arr * count_arr);
                                        }
                                        var now = DateTime.now();
                                        print(DateFormat.yMMMMd().format(now));
                                        cart_customer = cart_customer +
                                            "," +
                                            price_int.toString() +
                                            ",A D D R E S S" +
                                            "," +
                                            DateFormat.yMMMMd()
                                                .format(now)
                                                .toString();
                                        print(price_int);
                                        print(cart_customer);
                                        await FirebaseFirestore.instance
                                            .collection("customers")
                                            .doc(doc_id_)
                                            .get()
                                            .then((value) {
                                          count_order = value['count'];
                                        });
                                        count_order =
                                            (int.parse(count_order) + 1)
                                                .toString();
                                        await FirebaseFirestore.instance
                                            .collection("customers")
                                            .doc(doc_id_)
                                            .update({
                                          'order$count_order': cart_customer,
                                          'count': count_order,
                                        });
                                        print("no of orders");
                                        int no_of_orders_admin = 0;
                                        await FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc('count')
                                            .get()
                                            .then((value) =>
                                                no_of_orders_admin =
                                                    (int.parse(value['count']) +
                                                        1));
                                        await FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc('Order_$no_of_orders_admin')
                                            .set({
                                          'details': order_admin,
                                          'price': price_int,
                                          'customer_id': doc_id_,
                                          'order_count': count_order,
                                          'count': total_number_of_items,
                                          'status': "1",
                                          'customer_name': widget.name,
                                          'customer_address': widget.address,
                                          'customer_phone': widget.phone_number,
                                          'date': DateFormat.yMMMMd()
                                              .format(now)
                                              .toString(),
                                        });
                                        await FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc('count')
                                            .update({
                                          'count': no_of_orders_admin.toString()
                                        });
                                        await FirebaseFirestore.instance
                                            .collection("customers")
                                            .doc(doc_id_)
                                            .update({'cart': ""});
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()));
                                      },
                                      child: Text(
                                        'Order Now',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Row count_Widget_(int index, BuildContext context) {
    print("sdsd");
    return Row(
      children: [
        InkWell(
          onTap: () async {
            print("add");
            count[index] = (int.parse(count[index]) + 1).toString();
            setState(() {});
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(136, 148, 110, 1),
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ),
        count_Widget(context, count, index),
        InkWell(
          onTap: () {
            if (int.parse(count[index]) > 1) {
              count[index] = (int.parse(count[index]) - 1).toString();
              setState(() {});
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Warning',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'No of Counts for items cant be zero. Minimum count for each items should be one or more than one. ',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(136, 148, 110, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(136, 148, 110, 1),
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)),
            ),
            child: Icon(
              Icons.remove,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Container count_Widget(BuildContext context, List<dynamic> count, int index) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.1,
      color: Colors.grey.withOpacity(0.6),
      child: Center(
        child: Text(
          count[index],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
