import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals/screens/tabs.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userId;

  UserDetailsScreen({required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Add variables for height, weight, date of birth, name, and phone number
  var _enteredHeight = '';
  var _enteredWeight = '';
  var _enteredDateOfBirth = '';
  var _enteredName = '';
  var _enteredPhoneNumber = '';
  var _userName = ''; // Add a variable to store the username

  @override
  void initState() {
    super.initState();
    // Fetch the username when the screen is initialized
    _fetchUsername();
  }

  void _fetchUsername() async {
    try {
      // Retrieve the user document from Firestore based on userId
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

      // Get the username from the document
      final userName = userDoc['username'];

      setState(() {
        _userName = userName;
      });
    } catch (error) {
      // Handle the error (e.g., show a message)
      print('Error fetching username: $error');
    }
  }

  void _submitDetails() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      // show error message ...
      return;
    }

    _formKey.currentState!.save();

    // Save the user details to Firestore
    FirebaseFirestore.instance.collection('user_details').doc(widget.userId).set({
      'username': _userName, // Add username to the user_details document
      'height': _enteredHeight,
      'weight': _enteredWeight,
      'date_of_birth': _enteredDateOfBirth,
      'name': _enteredName,
      'phone_number': _enteredPhoneNumber,
      // Add other details fields as needed
    });

    // Navigate to the main app screen or any other screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => TabsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Username: $_userName'), // Display the username
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Height'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredHeight = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredWeight = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredDateOfBirth = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredPhoneNumber = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: _submitDetails,
                  child: Text('Save Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
