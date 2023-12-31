import 'package:flutter/material.dart';
import '../constant.dart';

// ignore: must_be_immutable
class ColorShowing extends StatelessWidget {
  String title;
  String image;

  ColorShowing({super.key, 
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  image,
                  height: 150,
                ),
              ),
              for (var entry in periodBloodColors.entries)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset(
                      colorImages[
                          index++], //use of postincrement so after doing it increases
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    for (var description in entry.value) Text(description),
                    const SizedBox(height: 16),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
