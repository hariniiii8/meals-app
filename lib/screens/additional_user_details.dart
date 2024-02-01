// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AdditionalDetailsScreen extends StatefulWidget {
//   final User user;

//   AdditionalDetailsScreen({required this.user});

//   @override
//   _AdditionalDetailsScreenState createState() => _AdditionalDetailsScreenState();
// }

// class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
//   final _form = GlobalKey<FormState>();

//   var _enteredAge = 0;
//   var _enteredHeight = 0.0;
//   var _enteredWeight = 0.0;
//   var _enteredGender = '';
//   var _enteredWeightGoal = '';

//   void _submit() {
//     final isValid = _form.currentState!.validate();

//     if (!isValid) {
//       return;
//     }

//     _form.currentState!.save();

//     // Call the signUpWithEmailAndPassword function with the additional details
//     signUpWithEmailAndPassword(
//       widget.user.email!,
//       'password123', // You may generate a random password or provide a field for the user to set it
//       widget.user.displayName!,
//       _enteredAge,
//       _enteredHeight,
//       _enteredWeight,
//       _enteredGender,
//       _enteredWeightGoal,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Additional Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _form,
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Age'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || int.tryParse(value) == null) {
//                       return 'Please enter a valid age.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _enteredAge = int.parse(value!);
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Height'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || double.tryParse(value) == null) {
//                       return 'Please enter a valid height.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _enteredHeight = double.parse(value!);
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Weight'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || double.tryParse(value) == null) {
//                       return 'Please enter a valid weight.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _enteredWeight = double.parse(value!);
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Gender'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your gender.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _enteredGender = value!;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Weight Goal'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your weight goal.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _enteredWeightGoal = value!;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 ElevatedButton(
//                   onPressed: _submit,
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
