import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/admin_homeScreen.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/order_DetailsScreen.dart';

class admin_Productdetails extends StatefulWidget {
  final String count_no_of_foods_FB;
  final String doc_id;
  final String calories;
  final String carbs;
  final String dressing; // doc_id:
  final String fats;
  final String image_url;
  final String ingredients;
  final String name;
  final String price;
  final String protein;
  const admin_Productdetails(
      {required this.doc_id,
      required this.calories,
      required this.count_no_of_foods_FB,
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
  State<admin_Productdetails> createState() => _admin_ProductdetailsState();
}

class _admin_ProductdetailsState extends State<admin_Productdetails> {
  TextEditingController _textFieldController = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  TextEditingController carbs = new TextEditingController();
  TextEditingController dressing = new TextEditingController();
  TextEditingController protein = new TextEditingController();
  TextEditingController fats = new TextEditingController();

  // doc_id:
  //     doc_id,
  // caloies: products[
  //     'calories'],
  // carbs: products[
  //     'carbs'],
  // dressing:
  //     products[
  //         'dressing'],
  // fats: products[
  //     'fats'],
  // image_url:
  //     products[
  //         'image_url'],
  // ingredients:
  //     products[
  //         'ingredients'],
  // name: products[
  //     'name'],
  // price: products[
  //     'price'],
  // protein: products[
  //     'protein'],
  // doc_id:
  //     doc_id,
  List unselected = [];
  List ingredient_add = [];
  _addItem(String item) {
    setState(() {
      ingredient_add.add(item);
    });
  }

  List ingredients = [];

  bool empty = false;
  bool editing = false;
  bool add_ingredients = false;
  @override
  Widget build(BuildContext context) {
    ingredients = (widget.ingredients.split(","));
    for (int i = 0; i < ingredient_add.length; i++) {
      ingredients.add(ingredient_add[i]);
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(136, 148, 110, 1),
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            leading: InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => admin_OrderScreen(
                      // return_: false,
                      )));
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 32.0,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      backgroundColor: Color.fromRGBO(136, 148, 110, 1),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.3,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.image_url),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !editing
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 8.0, left: 32.0),
                                child: Text(
                                  widget.name.toUpperCase(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      color: Color.fromRGBO(136, 148, 110, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 16.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: TextField(
                                    showCursor: false,
                                    autofocus: false,
                                    controller: name..text = widget.name,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            width: 1.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            width: 1.0),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                    maxLines: 1,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                        !editing
                            ? Padding(
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
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    showCursor: false,
                                    autofocus: false,
                                    controller: price..text = widget.price,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            width: 1.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                136, 148, 110, 1),
                                            width: 1.0),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                    maxLines: 1,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              top: MediaQuery.of(context).size.height * 0.02),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.003,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, left: 32.0),
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.05,
                            color: Color.fromRGBO(136, 148, 110, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    !editing
                        ? Container()
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Add Ingredient'),
                                      content: TextField(
                                        controller: _textFieldController,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: !empty
                                                    ? Colors.black
                                                    : Colors.red),
                                            hintText:
                                                "Enter the ingredient here"),
                                      ),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.16,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    136, 148, 110, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    136, 148, 110, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child: InkWell(
                                                onTap: () async {
                                                  if (_textFieldController
                                                      .text.isEmpty) {
                                                    empty = true;
                                                    setState(() {});
                                                  } else {
                                                    empty = false;
                                                    Navigator.pop(context);
                                                    _addItem(
                                                        _textFieldController
                                                            .text);
                                                  }
                                                },
                                                child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, left: 32.0),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(136, 148, 110, 1),
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Colors.white,
                                    ))),
                          ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                                    MediaQuery.of(context).size.width * 0.01,
                                backgroundColor:
                                    Color.fromRGBO(136, 148, 110, 1),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              !editing
                                  ? Flexible(
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
                                    )
                                  : Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          if (unselected.contains(index)) {
                                            unselected.remove(index);
                                          } else {
                                            unselected.add(index);
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  (unselected.contains(index))
                                                      ? Color.fromRGBO(
                                                          136, 148, 110, 0.3)
                                                      : Color.fromRGBO(
                                                          136, 148, 110, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          padding: EdgeInsets.all(8.0),
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
                                      ),
                                    )
                            ],
                          ),
                        ),
                      );
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    title_Style(context, "Calories :"),
                    !editing
                        ? value_Style(context, widget.calories)
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                showCursor: false,
                                autofocus: false,
                                controller: calories..text = widget.calories,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    title_Style(context, "Carbs :"),
                    !editing
                        ? value_Style(context, widget.carbs)
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                showCursor: false,
                                autofocus: false,
                                controller: carbs..text = widget.carbs,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                                maxLines: 1,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                  ],
                ),
                !editing
                    ? Row(
                        children: [
                          title_Style(context, "Dressing :"),
                          value_Style(context, widget.dressing)
                        ],
                      )
                    : Column(
                        children: [
                          title_Style(context, "Dressing :"),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 24.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                showCursor: false,
                                autofocus: false,
                                controller: dressing..text = widget.dressing,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                maxLines: 2,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                Row(
                  children: [
                    title_Style(context, "Protein :"),
                    !editing
                        ? value_Style(context, widget.protein)
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 24.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                showCursor: false,
                                autofocus: false,
                                controller: protein..text = widget.protein,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                                maxLines: 1,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    title_Style(context, "Fats :"),
                    !editing
                        ? value_Style(context, widget.fats)
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 24.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                showCursor: false,
                                autofocus: false,
                                controller: fats..text = widget.fats,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(136, 148, 110, 1),
                                        width: 1.0),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                                maxLines: 1,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
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
                        InkWell(
                          onTap: () {
                            print("edit");
                            editing = true;
                            setState(() {});
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Color.fromRGBO(136, 148, 110, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Center(
                              child: Text(
                                'Edit',
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Color.fromRGBO(136, 148, 110, 1),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                for (int i = 0; i < unselected.length; i++) {
                                  ingredients.removeAt(unselected[i]);
                                }
                                String ingredients_str = ingredients.join(",");
                                await FirebaseFirestore.instance
                                    .collection("menu_list")
                                    .doc(widget.doc_id)
                                    .update({
                                  'price': price.text,
                                  'calories': calories.text,
                                  'carbs': carbs.text,
                                  'dressing': dressing.text,
                                  'fats': fats.text,
                                  'ingredients': ingredients_str,
                                  'name': name.text,
                                  'protein': protein.text,
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => admin_OrderScreen()));
                              },
                              child: Text(
                                'Save',
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
                      ],
                    ))
              ],
            ),
          )),
    );
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
            color: Color.fromRGBO(136, 148, 110, 1),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
