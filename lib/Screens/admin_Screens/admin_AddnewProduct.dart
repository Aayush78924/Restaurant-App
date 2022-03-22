import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temp1/Screens/admin_Screens/admin_homeScreen.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class admin_AddnewProduct extends StatefulWidget {
  final String count;
  const admin_AddnewProduct({required this.count, Key? key}) : super(key: key);

  @override
  State<admin_AddnewProduct> createState() => _admin_AddnewProductState();
}

class _admin_AddnewProductState extends State<admin_AddnewProduct> {
  String? fileName;
  String? path;
  List<String> extensions = ["jpg", "png", ""];
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType? fileType;
  String imageurl = '';

  PickedFile? _photo;
  // XFile? _pick;
  ImagePicker _picker = ImagePicker();
  File? _file;
  Future imgFromGallery() async {
    try {
      print("13231");
      final _pick = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70);
      print("asaaaaaaaaaaaaaaaa");
      print("1");
      setState(() {
        if (_pick != null) {
          _file = File(_pick.path);
          uploadFile();
        } else {
          print('No image selected.');
        }
      });
      print("1");
    } catch (e) {
      print('error occured');
    }
  }

  Future uploadFile() async {
    print("1");
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      print("1");
      String url = '';
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref =
          storage.ref().child("image1" + DateTime.now().toString());
      firebase_storage.UploadTask uploadTask = ref.putFile(_file!);
      uploadTask.then((res) {
        url = res.ref.getDownloadURL().toString();
      });
      print(url);
      print("1");
    } catch (e) {
      print('error occured');
    }
  }

  TextEditingController _textFieldController = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  TextEditingController carbs = new TextEditingController();
  TextEditingController dressing = new TextEditingController();
  TextEditingController protein = new TextEditingController();
  TextEditingController fats = new TextEditingController();
  List unselected = [];
  var ingredient_add = [];
  _addItem(String item) {
    setState(() {
      ingredient_add.add(item);
      _textFieldController.text = "";
    });
  }

  bool empty = false;
  @override
  Widget build(BuildContext context) {
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
                    child: InkWell(
                      onTap: () {
                        imgFromGallery();
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.2,
                        backgroundColor: Color.fromRGBO(136, 148, 110, 1),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.3,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 16.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                              showCursor: false,
                              autofocus: false,
                              controller: name,
                              decoration: InputDecoration(
                                hintText: "Food Name",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              showCursor: false,
                              autofocus: false,
                              controller: price,
                              decoration: InputDecoration(
                                hintText: "Price",
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
                    InkWell(
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
                                      hintText: "Enter the ingredient here"),
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.16,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(136, 148, 110, 1),
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(136, 148, 110, 1),
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
                                                  _textFieldController.text);
                                            }
                                          },
                                          child: Text(
                                            'Add',
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
                                  ),
                                ],
                              );
                            });
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(top: 32.0, left: 32.0),
                          child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(136, 148, 110, 1),
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
                    itemCount: ingredient_add.length,
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
                              Flexible(
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
                                        color: (unselected.contains(index))
                                            ? Color.fromRGBO(136, 148, 110, 0.3)
                                            : Color.fromRGBO(136, 148, 110, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${ingredient_add[index]}',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          showCursor: false,
                          autofocus: false,
                          controller: calories,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          showCursor: false,
                          autofocus: false,
                          controller: carbs,
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
                Column(
                  children: [
                    title_Style(context, "Dressing :"),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          showCursor: false,
                          autofocus: false,
                          controller: dressing,
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
                            fontSize: MediaQuery.of(context).size.height * 0.02,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 24.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          showCursor: false,
                          autofocus: false,
                          controller: protein,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 24.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          showCursor: false,
                          autofocus: false,
                          controller: fats,
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
                InkWell(
                  onTap: () async {
                    print(ingredient_add);
                    print(unselected);
                    for (int i = 0; i < unselected.length; i++) {
                      ingredient_add.removeAt(unselected[i]);
                    }
                    String ingredients_str = ingredient_add.join(",");
                    await FirebaseFirestore.instance
                        .collection("menu_list")
                        .doc(widget.count)
                        .set({
                      'image_url':
                          "https://firebasestorage.googleapis.com/v0/b/health-do.appspot.com/o/avacoda-green_bowl.jpg?alt=media&token=9868a022-73f7-4f0e-83f0-a287da77fc30",
                      'calories': calories.text,
                      'carbs': carbs.text,
                      'dressing': dressing.text,
                      'fats': fats.text,
                      'ingredients': ingredients_str,
                      'name': name.text,
                      'protein': protein.text,
                      'price': price.text
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => admin_OrderScreen()));
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Color.fromRGBO(136, 148, 110, 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          )),
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
