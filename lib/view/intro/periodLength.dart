import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';
import 'package:stritva/model/user_data.dart';
import 'package:stritva/view/intro/getPresentDate.dart';

class PeriodLength extends StatefulWidget {
  const PeriodLength({super.key});

  @override
  _PeriodLength createState() => _PeriodLength();
}

class _PeriodLength extends State<PeriodLength> {
  int periodLength = 4;

  void _showCycleLengthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PeriodLengthPickerDialog(
          initialPeriodLength: periodLength,
          onChanged: (value) {
            setState(() {
              periodLength = value;
            });
          },
          onSaved: () {
            // Use the selected menstrual cycle length (menstrualCycleLength) as needed
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final heightTotal = size.height;
    final height = heightTotal - heightTotal * 0.2;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'asset/images/flow_length.png',
              height: height * 0.60466,
            ),
            Text(
              'Blood Flow Length?',
              style: TextStyle(color: buttonColor, fontSize: width * 0.0766),
            ),
            SizedBox(
              height: height * 0.0755835,
            ),
            PeriodLengthValueText(periodLength: periodLength),

            SizedBox(
              height: height * 0.0755835,
            ),

            // Button to show the modal bottom sheet
            TextButton(
              onPressed: _showCycleLengthPicker,
              child: const Text(
                'Set Blood Flow Length',
                style: TextStyle(color: borderColor),
                selectionColor: borderColor,
              ),
            ),

            SizedBox(
              height: height * 0.136,
            ),
            TextButton.icon(
              onPressed: () {
                Provider.of<UserData>(context, listen: false)
                    .addPeriodLength(periodLength);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const GetPresentDate();
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
    );
  }
}

class PeriodLengthPickerDialog extends StatefulWidget {
  final int initialPeriodLength;
  final ValueChanged<int> onChanged;
  final VoidCallback onSaved;

  const PeriodLengthPickerDialog({
    super.key,
    required this.initialPeriodLength,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PeriodLengthPickerDialogState createState() =>
      _PeriodLengthPickerDialogState();
}

class _PeriodLengthPickerDialogState extends State<PeriodLengthPickerDialog> {
  int _periodLength = 4;

  @override
  void initState() {
    super.initState();
    _periodLength = widget.initialPeriodLength;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Blood Flow Length',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NumberPicker(
            step: 1,
            value: _periodLength,
            minValue: 1,
            maxValue: 10, // Adjust the maximum value as needed
            onChanged: (value) {
              setState(() {
                _periodLength = value;
                widget.onChanged(value);
              });
            },
            itemWidth: 60,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: borderColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Save',
            style: TextStyle(color: borderColor),
          ),
          onPressed: () {
            // Use the selected menstrual cycle length (flowLengthNotifier.value) as needed
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class PeriodLengthValueText extends StatefulWidget {
  late int periodLength;

  PeriodLengthValueText({
    super.key,
    required this.periodLength,
  });

  @override
  _PeriodLengthValueTextState createState() => _PeriodLengthValueTextState();
}

class _PeriodLengthValueTextState extends State<PeriodLengthValueText> {
  late int periodLength;

  @override
  void initState() {
    super.initState();
    periodLength = widget.periodLength;
  }

  @override
  void didUpdateWidget(PeriodLengthValueText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.periodLength != oldWidget.periodLength) {
      setState(() {
        periodLength = widget.periodLength;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$periodLength',
      style: TextStyle(
        fontSize: 33,
        color: buttonColor,
      ),
    );
  }
}
