import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constant.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Widget _buildOptions(String title, String image, Color bgroundColor) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 2),
      padding: EdgeInsets.all(5),
      height: 110,
      width: 140,
      decoration: BoxDecoration(
          color: bgroundColor,
          border: Border.all(width: 1, color: bgroundColor!),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 60,
            width: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(color: buttonColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _showTitle(String title) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 50, bottom: 10)),
        _showTitle('How to Use'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildOptions('Disposable Pad', 'asset/images/disposable_pad.png',
                  Color.fromARGB(255, 0, 180, 189)),
              _buildOptions(
                  'Menstrual Cloth',
                  'asset/images/menstrual_cloth.png',
                  Color.fromARGB(255, 21, 125, 148)),
              _buildOptions('Reusable Pad', 'asset/images/reusable_pad.png',
                  Color.fromARGB(255, 118, 199, 194)),
              _buildOptions('Tampon', 'asset/images/tampons.png',
                  Color.fromARGB(255, 21, 141, 125)),
              _buildOptions('Menstrual Cup', 'asset/images/mestrual_cup.png',
                  Color.fromARGB(255, 85, 150, 123)),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        _showTitle('Color Guide'),
        _buildOptions(
            'Color Guide', 'asset/images/color_title.png', Colors.white),
        _showTitle('Myths and Facts'),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            _buildOptions('Myths', 'asset/images/myth.png',
                Color.fromARGB(80, 179, 89, 48)),
            _buildOptions('Facts', 'asset/images/fact.png', Colors.white),
          ],
        ),
        _showTitle('Key Terms'),
        _buildOptions('Key Terms', 'asset/images/key_terms.png', Colors.white),
      ],
    );
  }
}
