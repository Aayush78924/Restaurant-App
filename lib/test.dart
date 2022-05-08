// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// test(BuildContext context) {
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.05,
//     width: MediaQuery.of(context).size.width * 0.4,
//     decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         color: const Color.fromRGBO(136, 148, 110, 1),
//         borderRadius: const BorderRadius.all(Radius.circular(30))),
//     child: Center(
//       child: InkWell(
//         onTap: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: const Text('Add Ingredient'),
//                   content: TextField(
//                     controller: _textFieldController,
//                     decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                             color: !empty ? Colors.black : Colors.red),
//                         hintText: "Enter the ingredient here"),
//                   ),
//                   actions: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.05,
//                         width: MediaQuery.of(context).size.width * 0.16,
//                         decoration: const BoxDecoration(
//                             color: Color.fromRGBO(136, 148, 110, 1),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                         child: Center(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                               setState(() {});
//                             },
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(
//                                   fontSize: MediaQuery.of(context).size.height *
//                                       0.025,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.05,
//                         width: MediaQuery.of(context).size.width * 0.12,
//                         decoration: const BoxDecoration(
//                             color: Color.fromRGBO(136, 148, 110, 1),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                         child: Center(
//                           child: InkWell(
//                             onTap: () async {
//                               if (_textFieldController.text.isEmpty) {
//                                 empty = true;
//                                 setState(() {});
//                               } else {
//                                 empty = false;
//                                 Navigator.pop(context);
//                                 _addItem(_textFieldController.text);
//                               }
//                             },
//                             child: Text(
//                               'Add',
//                               style: TextStyle(
//                                   fontSize: MediaQuery.of(context).size.height *
//                                       0.025,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               });
//         },
//         child: Text(
//           'Modify',
//           style: TextStyle(
//               fontSize: MediaQuery.of(context).size.height * 0.025,
//               color: Colors.white,
//               fontWeight: FontWeight.w500),
//         ),
//       ),
//     ),
//   );
// }
