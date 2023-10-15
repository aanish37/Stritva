import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';
import 'package:stritva/model/logic.dart';
import 'package:intl/intl.dart';
import '../model/user_data.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false).user;
    final userName = user.username;
    final periodLength = user.periodLength;
    final cycleLength = user.cycleLength;
    final recentPeriodDate = user.recentPeriodDate;

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '  नमस्कार,  ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              // Container(
              //     height: 50,
              //     width: 50,
              //     child: Image.asset('asset/images/namaskar.png')),
              SizedBox(width: width * 0.03826),
              Text(
                userName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(
                width: width * .3,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.022093,
          ),
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 246, 227, 227),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height * 0.0846,
                    child: Image.asset('asset/images/clock.png'),
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat.yMMMd().format(date),
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        DateFormat.EEEE().format(date),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .044,
          ),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                todayDetails(
                    'Today\'s Phase',
                    calculateMenstrualPhase(DateTime.now(), periodLength,
                            cycleLength, recentPeriodDate)
                        .values
                        .elementAt(0),
                    size),
                todayDetails(
                  'Pregnancy',
                  '${calculateMenstrualPhase(DateTime.now(), periodLength, cycleLength, recentPeriodDate).values.elementAt(1)} chance',
                  size,
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: height * .034),
              alignment: Alignment.center,
              height: height * .27,
              width: width * .9,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'My Cycle',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * .019,
                    ),
                    Row(children: [
                      _showContainer('Period Length', periodLength, size),
                      SizedBox(
                        width: height * .017,
                      ),
                      _showContainer('Cycle Length', cycleLength, size),
                    ]),
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  Widget _showContainer(name, length, size) {
    final height = size.height;
    final width = size.width;
    String status = 'Normal';

    //some logic to calculate whether it is normal or bad
    //
    //
    if (name == 'Period Length') {
      if (length < 7 && length > 2) {
        status = 'Normal';
      } else {
        status = 'Bad';
      }
    }

    if (name == 'Cycle Length') {
      if (length < 35 && length > 21) {
        status = 'Normal';
      } else {
        status = 'Bad';
      }
    }
    return Card(
      elevation: 10,
      color: const Color.fromARGB(255, 246, 227, 227),
      surfaceTintColor: const Color.fromARGB(255, 246, 227, 227),
      child: Container(
        height: height * 0.18744,
        width: width * 0.395,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: status == 'Normal'
                    ? const Color.fromARGB(255, 31, 190, 123)
                    : Colors.red,
              ),
            ),
            Text(
              length.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: buttonColor,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: height * 0.012,
            ),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget todayDetails(String name, String data, size) {
    final height = size.height;
    final width = size.width;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: const Color.fromARGB(255, 246, 227, 227),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 246, 227, 227),
        ),
        height: height * 0.2418,
        width: width * 0.43280,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: width * 0.04591, fontWeight: FontWeight.w400)),
              Text(data,
                  style: TextStyle(
                      fontSize: width * 0.051, fontWeight: FontWeight.bold)),
              const Text(
                'Know your Period days better',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(children: [
                    Text(
                      'Read More',
                      style: TextStyle(color: buttonColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: buttonColor,
                    )
                  ])),
            ]),
      ),
    );
  }
}
