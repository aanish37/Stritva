import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';
import 'package:stritva/model/user_data.dart';
import './cycleLength.dart';

// ignore: must_be_immutable
class UserName extends StatelessWidget {
  TextEditingController userNmaeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final heightTotal = size.height;
    final height = heightTotal - heightTotal * 0.2;
    final width = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'asset/images/third_girl.jpg',
              height: height * 0.68,
            ),
            Text(
              'What should we call you?',
              style: TextStyle(color: buttonColor, fontSize: 25),
            ),
            SizedBox(height: height * 0.0375),
            SizedBox(
              width: width * 0.9375,
              child: TextField(
                style: const TextStyle(fontWeight: FontWeight.w400),
                controller: userNmaeController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(
                      color: borderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.0375),
            SizedBox(
              width: width * 0.9375,
              child: TextField(
                controller: emailController,
                style: const TextStyle(fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      color: borderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.14025,
            ),
            TextButton.icon(
              onPressed: () {
                if (userNmaeController.text.isNotEmpty &&
                    emailController.text.isNotEmpty) {
                  Provider.of<UserData>(context, listen: false).addNameEmail(
                      userNmaeController.text, emailController.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const CycleLength();
                    }),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill all the fields'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
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
          ],
        ),
      ),
    );
  }
}
