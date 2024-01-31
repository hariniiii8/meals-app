import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatelessWidget {
  final User user;

  SettingsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        color: Color.fromRGBO(138, 71, 235, 1), // Purple background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // You can customize the text style further if needed
              ),
              SizedBox(height: 10),
              Text('Email: ${user.email}', style: TextStyle(color: Colors.white)),
              Text('UID: ${user.uid}', style: TextStyle(color: Colors.white)),
              // Add more user details as needed
            ],
          ),
        ),
      ),
    );
  }
}
