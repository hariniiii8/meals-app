// intro2.dart
import 'package:flutter/material.dart';
import 'package:meals/screens/intro2.dart';

class Intro1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(138, 71, 235, 1),
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Image.asset('assets/food_image1.jpeg', height: 200, width: 200),
          SizedBox(height: 20),
          Text(
            'From plate to progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Your personalised pathway',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '"Elevate your wellness journey! '
                ' Discover personalised motivation,'
                'expert advice and a supportive '
                'community. Lets embrace a healthier'
                'Lifestyle, step by step!"',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideBar(isSelected: true),
              SlideBar(),
              SlideBar(),
            ],
          ),
          Spacer(),
          SizedBox(
            width: 150, // Set the button width
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Intro2Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Set the button color
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.black, // Set the button text color
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SlideBar extends StatelessWidget {
  final bool isSelected;

  SlideBar({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 5,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}