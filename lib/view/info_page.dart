import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stritva/view/showDetails.dart';
import 'color_showing.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  _showDetails(String title, String image, BuildContext context, int index) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => index == 8
              ? ColorShowing(title: title, image: image)
              : ShowDetails(
                  title: title,
                  image: image,
                  index: index,
                ),
        ),
      );
    };
  }

  Widget _buildOptions(String title, String image, BuildContext context,
      int index, double height, double width) {
    return GestureDetector(
      onTap: _showDetails(title, image, context, index),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(5),
          height: height * 0.145,
          width: width * 0.3564,
          decoration: BoxDecoration(
              //   boxShadow: [
              //   BoxShadow(
              //       spreadRadius: 1,
              //       color: Colors.black, //New
              //       blurRadius: 1.0,
              //       offset: Offset(0, 1)),

              // ],
              color: const Color.fromARGB(255, 246, 227, 227),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: height * 0.072,
                width: width * 0.1528,
              ),
              SizedBox(
                height: height * 0.010,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: 'Ubuntu',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 0, bottom: 10)),
            _showTitle('How to Use'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildOptions(
                      'Disposable Pad',
                      'asset/images/disposable_pad.png',
                      context,
                      0,
                      height,
                      width),
                  _buildOptions(
                      'Menstrual Cloth',
                      'asset/images/menstrual_cloth.png',
                      context,
                      1,
                      height,
                      width),
                  _buildOptions('Reusable Pad', 'asset/images/reusable_pad.png',
                      context, 2, height, width),
                  _buildOptions('Tampon', 'asset/images/tampons.png', context,
                      3, height, width),
                  _buildOptions(
                      'Menstrual Cup',
                      'asset/images/mestrual_cup_rm.png',
                      context,
                      4,
                      height,
                      width),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            _showTitle('Color Guide'),
            _buildOptions('Color Guide', 'asset/images/color.png', context, 8,
                height, width),
            _showTitle('Myths and Facts'),
            SingleChildScrollView(
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _buildOptions('Myths', 'asset/images/myth.png', context, 5,
                      height, width),
                  _buildOptions('Facts', 'asset/images/fact.png', context, 6,
                      height, width),
                ],
              ),
            ),
            _showTitle('Key Terms'),
            _buildOptions('Key Terms', 'asset/images/key_terms.png', context, 7,
                height, width),
          ],
        ),
      ),
    );
  }
}
