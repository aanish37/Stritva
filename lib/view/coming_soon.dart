import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: backgroundColor,
        title: const Text(
          'Coming Soon',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(color: buttonColor, fontSize: 30),
        ),
      ),
    );
  }
}
