import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constant.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Widget _buildOptions(
    String title,
    String image,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 2),
      padding: EdgeInsets.all(5),
      height: 120,
      width: 140,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 1,
            color: Colors.black, //New
            blurRadius: 1.0,
            offset: Offset(0, 1)),
        BoxShadow(
            spreadRadius: 1,
            color: Colors.black, //New
            blurRadius: 2.0,
            offset: Offset(0, 3)),
        BoxShadow(
            spreadRadius: 1,
            color: Colors.black, //New
            blurRadius: 2.0,
            offset: Offset(0, 3)),
        BoxShadow(
            spreadRadius: 1,
            color: Colors.black, //New
            blurRadius: 2.0,
            offset: Offset(0, 3))
      ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
            color: buttonColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 50, bottom: 10)),
          _showTitle('How to Use'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildOptions(
                    'Disposable Pad', 'asset/images/disposable_pad.png'),
                _buildOptions(
                  'Menstrual Cloth',
                  'asset/images/menstrual_cloth.png',
                ),
                _buildOptions(
                  'Reusable Pad',
                  'asset/images/reusable_pad.png',
                ),
                _buildOptions(
                  'Tampon',
                  'asset/images/tampons.png',
                ),
                _buildOptions(
                  'Menstrual Cup',
                  'asset/images/mestrual_cup_rm.png',
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          _showTitle('Color Guide'),
          _buildOptions('Color Guide', 'asset/images/color.png'),
          _showTitle('Myths and Facts'),
          SingleChildScrollView(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(top: 30)),
                _buildOptions(
                  'Myths',
                  'asset/images/myth.png',
                ),
                _buildOptions(
                  'Facts',
                  'asset/images/fact.png',
                ),
              ],
            ),
          ),
          _showTitle('Key Terms'),
          _buildOptions('Key Terms', 'asset/images/key_terms.png'),
        ],
      ),
    );
  }
}
