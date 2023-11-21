import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';
import 'package:stritva/view/intro/username.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.14140041,
          ),
          Text(
            'Track Your Periods & Fertility ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: width * 0.09,
                color: buttonColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: height * 0.1037),
          SizedBox(
            width: width * 0.76,
            child: Image.asset('asset/images/girl.png'),
          ),
          SizedBox(height: height * 0.2372),
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return UserName();
                }),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.25, vertical: height * 0.02418),
            ),
          ),
        ]),
      ),
    );
  }
}
