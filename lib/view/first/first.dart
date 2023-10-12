import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';
import './second.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: 150,
          ),
          Text(
            'Welcome!',
            style: TextStyle(
                fontSize: 40, color: buttonColor, fontWeight: FontWeight.bold),
          ),
          Container(width: 300, child: Image.asset('asset/images/logo.png')),
          SizedBox(height: 200),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SecondPage();
                }),
              );
            },
            child: Text('Get Started'),
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
