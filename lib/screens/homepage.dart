// import 'package:flutter/animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mannkibaat/screens/listingPage.dart';
// import 'package:mannkibaat/widgets/Button.dart';
//
// import 'diarypage.dart';
//
// class HomePage extends StatefulWidget {
//   static const String id = 'homepage';
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   Future<bool> _onBackPressed() {
//     return showDialog(
//       context: context,
//       builder: (context) => new AlertDialog(
//         title: new Text('Are you sure?'),
//         content: new Text('Do you want to exit an App'),
//         actions: <Widget>[
//           Button(
//             title: 'No',
//             color: Color(0xFF167F67),
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//           ),
//           Button(
//             title: 'Yes',
//             color: Color(0xFF167F67),
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//           ),
//         ],
//       ),
//     ) ??
//         false;
//   }
//   var shareYourDay = TextEditingController();
//   DateTime now = new DateTime.now();
//
//   String month = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Center(
//             child: Text(
//               'Diary Entry',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           actions: <Widget>[
//
//             Button(
//               title: "Diary",
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(context, DiaryPage.id, (route) => false);
//       }
//             ),
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, ListingPage.id, (route) => false);
//                   },
//                   child: Center(
//                       child: Text(
//                     'Listings',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Colors.black),
//                   )),
//                 )),
//           ],
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     child: TextFormField(
//                       controller: shareYourDay,
//                       maxLines: 13,
//                       decoration: InputDecoration(
//                         labelText: 'Share your day',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0))),
//                       ),
//                     ),
//                     height: 300,
//                     width: 350,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       'Previous Entries',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           image: DecorationImage(
//                             image: AssetImage('images/stickyNotes.png')
//                           )
//                         ),
//                         height: 90,
//                         width: 110,
//                         child: Center(
//                             child: Text(
//                           '${now.day} Feb',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                               fontSize: 18),
//                         )),
//                       ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               image: DecorationImage(
//                                   image: AssetImage('images/stickyNotes.png')
//                               )
//                           ),
//                           height: 90,
//                           width: 110,
//                           child: Center(
//                             child: Text(
//                               '${now.day - 1} Feb',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   fontSize: 18),
//                             ),
//                           ),
//                         ),
//
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             image: DecorationImage(
//                                 image: AssetImage('images/stickyNotes.png')
//                             )
//                         ),
//                         height: 90,
//                         width: 110,
//                         child: Center(
//                           child: Text('${now.day - 2} Feb',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   fontSize: 18)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//
//
//                   ////////////////////////////////////////////
//                   Text(
//                     'Recommendations',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blueAccent),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             image: DecorationImage(
//                                 image: AssetImage('images/stickyNotes.png')
//                             )
//                         ),
//                         height: 90,
//                         width: 110,
//                         child: Center(
//                             child: Text(
//                               '${now.day} Feb',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   fontSize: 18),
//                             )),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             image: DecorationImage(
//                                 image: AssetImage('images/stickyNotes.png')
//                             )
//                         ),
//                         height: 90,
//                         width: 110,
//                         child: Center(
//                           child: Text(
//                             '${now.day - 1} Feb',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             image: DecorationImage(
//                                 image: AssetImage('images/stickyNotes.png')
//                             )
//                         ),
//                         height: 90,
//                         width: 110,
//                         child: Center(
//                           child: Text('${now.day - 2} Feb',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   fontSize: 18)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         border: Border.all(
//                           color: Colors.indigo,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       height: 50,
//                       width: 100,
//                       child: Center(
//                         child: Text(
//                           'Voice',
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
