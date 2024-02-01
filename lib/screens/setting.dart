// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SettingsScreen extends StatelessWidget {
//   final User user;

//   SettingsScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('userDetails').doc(user.uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Text('User details not found.');
//           }

//           Map<String, dynamic> userDetails = snapshot.data!.data() as Map<String, dynamic>;

//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'User Details:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text('Email: ${user.email}'),
//                 Text('Display Name: ${user.displayName}'),
//                 Text('Age: ${userDetails['age']}'),
//                 Text('Height: ${userDetails['height']}'),
//                 Text('Weight: ${userDetails['weight']}'),
//                 Text('Gender: ${userDetails['gender']}'),
//                 Text('Weight Goal: ${userDetails['weightGoal']}'),
//                 // Add more user details as needed
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
