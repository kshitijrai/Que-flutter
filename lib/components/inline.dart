// import 'package:Que/components/store.dart';
// import 'package:Que/refer/size_config.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Inline extends StatelessWidget {
//   const Inline({
//     Key key,
//     @required this.usersid,
//   }) : super(key: key);

//   final List<String> usersid;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(
//           usersid.length, (index) => addInline(usersid: usersid[index])),
//     );
//   }

//   Row addInline({String usersid}) {
//     User user = FirebaseAuth.instance.currentUser;
//     Store store;
//       DocumentReference stores =
//           FirebaseFirestore.instance.collection('stores').doc(store.storeName);

//         return stores
//             .update({
//              'inline': (
//               usersid.length, (index) => add(usersid: usersid[index])),
//             })
//             .then((value) => {
//                   print("User Name Added"),
//                   Navigator.pop(context),
//                 })
//             .catchError(
//               (error) => print("Failed to add user: $error"),
//             );

// }
