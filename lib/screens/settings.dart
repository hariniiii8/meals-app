import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  final String userId;

  SettingsScreen({required this.userId});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _userName = '';
  var _userHeight = '';
  var _userWeight = '';

  @override
  void initState() {
    super.initState();
    // Fetch user details when the screen is initialized
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    try {
      // Retrieve the user details document from Firestore based on userId
      final userDetailsDoc = await FirebaseFirestore.instance.collection('user_details').doc(widget.userId).get();

      // Get the details from the document
      final userName = userDetailsDoc['username'];
      final userHeight = userDetailsDoc['height'];
      final userWeight = userDetailsDoc['weight'];

      setState(() {
        _userName = userName;
        _userHeight = userHeight;
        _userWeight = userWeight;
      });
    } catch (error) {
      // Handle the error (e.g., show a message)
      print('Error fetching user details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Add icon for Logout
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text(
              'User Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 10),
            Card(
              elevation: 3,
              child: Container(
                color:const Color.fromRGBO(138, 71, 235, 1),
                child: ListTile(
                  title: const Text(
                    'Username:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    _userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                color:const Color.fromRGBO(138, 71, 235, 1),
                child: ListTile(
                  title: const Text(
                    'Height:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    _userHeight,
                    style:const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                color: const Color.fromRGBO(138, 71, 235, 1),
                child: ListTile(
                  title: const Text(
                    'Weight:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    _userWeight,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
