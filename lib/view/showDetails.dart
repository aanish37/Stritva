// ignore: file_names
import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';

// ignore: must_be_immutable
class ShowDetails extends StatelessWidget {
  String title;
  String image;
  int index;
  ShowDetails({super.key, required this.title, required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    Map<String, List<String>> selectedGuidelines =
        menstrualGuidelines.values.toList()[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                height: height * 0.1814,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedGuidelines.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Column(
                      children: entry.value.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
