import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Provider/add_ingredients.dart';
import 'package:temp1/Screens/home_Screen.dart';

class product_Details extends ConsumerStatefulWidget {
  final String caloies;
  final String carbs;
  final String dressing;
  final String fats;
  final String image_url;
  final String ingredients;
  final String name;
  final String price;
  final String protein;
  const product_Details(
      {required this.caloies,
      required this.carbs,
      required this.dressing,
      required this.fats,
      required this.image_url,
      required this.ingredients,
      required this.name,
      required this.price,
      required this.protein,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _product_DetailsState();
  }
}

class _product_DetailsState extends ConsumerState<product_Details> {
  var ingredient_add = [];
  _addItem(String item) {
    setState(() {
      ingredient_add.add(item);
    });
  }

  String? doc_id_ = '';
  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    doc_id_ = prefs.getString('doc_id');
    return 1;
  }

  @override
  void initState() {
    super.initState();
    ref.read(addIngredientProvider).clear();
    getSharedPrefs();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ingredients = (widget.ingredients.split(",").toList());
    for (int i = 0; i < ingredient_add.length; i++) {
      ingredients.add(ingredient_add[i]);
    }
    TextEditingController _textFieldController = TextEditingController();
    bool empty = false;
    var itemsingredients = ref.watch(addIngredientProvider);
    return FutureBuilder(
        future: getSharedPrefs(),
        builder: (ctx, snapshot) {
          if (snapshot.data == 1) {
            return SafeArea(
              child: Scaffold(
                  floatingActionButton: FloatingActionButton(onPressed: () {
                    ref.read(addIngredientProvider).clear();
                  }),
                  appBar: AppBar(
                    backgroundColor: const Color.fromRGBO(136, 148, 110, 1),
                    toolbarHeight: MediaQuery.of(context).size.height * 0.08,
                    leading: InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          //color: Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.2,
                              backgroundColor:
                                  const Color.fromRGBO(136, 148, 110, 1),
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.3,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(widget.image_url),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 8.0, left: 32.0),
                                  child: Text(
                                    widget.name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        color: const Color.fromRGBO(
                                            136, 148, 110, 1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 32.0),
                                  child: Text(
                                    'Rs. ${widget.price}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.1,
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.003,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 32, top: 16.0, bottom: 8.0, left: 32.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ingredients',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      color: const Color.fromRGBO(
                                          136, 148, 110, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAddDialog(context, ingredients, ref);
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline_outlined,
                                    color:
                                        const Color.fromRGBO(136, 148, 110, 1),
                                    size: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 8.0, left: 32.0),
                          child: Container(
                            child: itemsingredients.ingredients.isEmpty
                                ? const Text(
                                    'No ingredients added yet',
                                  )
                                : ListView.builder(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        itemsingredients.ingredients.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            top: 16.0,
                                            bottom: 16.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        136, 148, 110, 1),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  itemsingredients
                                                      .ingredients[index],
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  ref
                                                      .read(
                                                          addIngredientProvider)
                                                      .removeIngredients(
                                                          itemsingredients
                                                                  .ingredients[
                                                              index]);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromRGBO(
                                                      136, 148, 110, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        Row(
                          children: [
                            title_Style(context, "Calories :"),
                            value_Style(context, widget.caloies),
                          ],
                        ),
                        Row(
                          children: [
                            title_Style(context, "Carbs :"),
                            value_Style(context, widget.carbs),
                          ],
                        ),
                        Row(
                          children: [
                            title_Style(context, "Dressing :"),
                            value_Style(context, widget.dressing),
                          ],
                        ),
                        Row(
                          children: [
                            title_Style(context, "Protein :"),
                            value_Style(context, widget.protein),
                          ],
                        ),
                        Row(
                          children: [
                            title_Style(context, "Fats :"),
                            value_Style(context, widget.fats),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 3.0,
                                        color: Colors.grey.withOpacity(0.8)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color:
                                        const Color.fromRGBO(136, 148, 110, 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Add to cart',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.028,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                  'Are you sure to add to cart',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.16,
                                                      decoration: const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              136, 148, 110, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                fontSize: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .height *
                                                                    0.025,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.12,
                                                      decoration: const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              136, 148, 110, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            String lenn =
                                                                (itemsingredients
                                                                        .ingredients
                                                                        .length)
                                                                    .toString();
                                                            String
                                                                modifyIngredients;

                                                            if (itemsingredients
                                                                .ingredients
                                                                .isEmpty) {
                                                              modifyIngredients =
                                                                  'none';
                                                              lenn = "1";
                                                            } else {
                                                              modifyIngredients =
                                                                  itemsingredients
                                                                      .ingredients[0];
                                                            }

                                                            for (int i = 1;
                                                                i <
                                                                    itemsingredients
                                                                        .ingredients
                                                                        .length;
                                                                i++) {
                                                              modifyIngredients =
                                                                  modifyIngredients +
                                                                      "," +
                                                                      itemsingredients
                                                                          .ingredients[i];
                                                            }
                                                            String cart = "";
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "customers")
                                                                .doc(doc_id_)
                                                                .get()
                                                                .then((value) =>
                                                                    print(cart =
                                                                        value[
                                                                            'cart']));
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "customers")
                                                                .doc(doc_id_)
                                                                .update({
                                                              'cart': cart +
                                                                  "," +
                                                                  widget
                                                                      .image_url +
                                                                  "," +
                                                                  widget.name +
                                                                  "," +
                                                                  widget.price +
                                                                  ",1,length," +
                                                                  lenn +
                                                                  "," +
                                                                  modifyIngredients
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                            'Add',
                                                            style: TextStyle(
                                                                fontSize: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .height *
                                                                    0.025,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Text(
                                        'Add to cart',
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
                              ],
                            ))
                      ],
                    ),
                  )),
            );
          } else {
            return Container();
          }
        });
  }

  Padding value_Style(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 16.0),
      child: Text(
        value,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
            color: Colors.black,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding title_Style(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 32.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: const Color.fromRGBO(136, 148, 110, 1),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

Future<dynamic> showAddDialog(
    BuildContext context, List<String> ingredients, WidgetRef ref) {
  var items = ref.watch(addIngredientProvider).ingredients;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ingredients.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext, index) {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(addIngredientProvider)
                        .addIngredients(ingredients[index]);
                    log(ingredients[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 16.0, bottom: 16.0),
                    child: Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.01,
                            backgroundColor:
                                const Color.fromRGBO(136, 148, 110, 1),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Flexible(
                            child: Text(
                              ingredients[index],
                              style: TextStyle(
                                  overflow: TextOverflow.visible,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    },
  );
}
