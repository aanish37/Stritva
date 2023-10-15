import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';
import 'package:provider/provider.dart';
import 'package:stritva/view/home_page.dart';
import '../../model/user_data.dart';

class GetPresentDate extends StatefulWidget {
  const GetPresentDate({super.key});

  @override
  _GetPresentDate createState() => _GetPresentDate();
}

class _GetPresentDate extends State<GetPresentDate> {
  DateTime _recentPeriodDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _recentPeriodDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _recentPeriodDate) {
      setState(() {
        _recentPeriodDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(height * 0.0019),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: height * 0.0241,
                ),
                height: height * 0.4839,
                width: width * 0.9,
                child: Image.asset(
                  'asset/images/present_date.png',
                  height: height * 0.4839,
                ),
              ),
              Text(
                'Select your recent period date..',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: width * 0.0765,
                ),
              ),
              SizedBox(height: height * 0.0241),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: "${_recentPeriodDate.toLocal()}".split(' ')[0]),
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: "Recent Period Date",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Icon(
                      Icons.calendar_today,
                      color: buttonColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.14889),
              TextButton.icon(
                onPressed: () {
                  Provider.of<UserData>(context, listen: false)
                      .addRecentPeriodDate(_recentPeriodDate);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
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
      ),
    );
  }
}
