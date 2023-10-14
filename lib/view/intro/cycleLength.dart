// ignore: file_names
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stritva/constant.dart';
import './periodLength.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';

class CycleLength extends StatefulWidget {
  const CycleLength({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CycleLength createState() => _CycleLength();
}

class _CycleLength extends State<CycleLength> {
  int menstrualCycleLength = 28; // Default value

  void _showCycleLengthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CycleLengthPickerDialog(
          initialCycleLength: menstrualCycleLength,
          onChanged: (value) {
            setState(() {
              menstrualCycleLength = value;
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
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.01040041,
            ),
            Image.asset(
              'asset/images/period_cycle.png',
              height: height * 0.55,
            ),
            const Text(
              'Menstrual Cycle Length?',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: height * 0.0555835,
            ),
            CycleLengthValueText(
              menstrualCycleLength: menstrualCycleLength,
            ),
            SizedBox(
              height: height * 0.01075,
            ),

            // Button to show the modal bottom sheet
            TextButton(
              onPressed: _showCycleLengthPicker,
              child: const Text(
                'Set Menstrual Cycle Length',
                style: TextStyle(color: borderColor),
                selectionColor: borderColor,
              ),
            ),

            SizedBox(
              height: height * 0.103,
            ),
            TextButton.icon(
              onPressed: () {
                Provider.of<UserData>(context, listen: false)
                    .addCycleLength(menstrualCycleLength);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PeriodLength();
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

class CycleLengthPickerDialog extends StatefulWidget {
  final int initialCycleLength;
  final ValueChanged<int> onChanged;
  final VoidCallback onSaved;

  const CycleLengthPickerDialog({
    super.key,
    required this.initialCycleLength,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  _CycleLengthPickerDialogState createState() =>
      _CycleLengthPickerDialogState();
}

class _CycleLengthPickerDialogState extends State<CycleLengthPickerDialog> {
  int selectedCycleLength = 28;

  @override
  void initState() {
    super.initState();
    selectedCycleLength = widget.initialCycleLength;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Menstrual Cycle Length'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NumberPicker(
            step: 1,
            value: selectedCycleLength,
            minValue: 15,
            maxValue: 50,
            onChanged: (value) {
              setState(() {
                selectedCycleLength = value;
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
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class CycleLengthValueText extends StatefulWidget {
  final int menstrualCycleLength;

  const CycleLengthValueText({
    super.key,
    required this.menstrualCycleLength,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CycleLengthValueTextState createState() => _CycleLengthValueTextState();
}

class _CycleLengthValueTextState extends State<CycleLengthValueText> {
  late int menstrualCycleLength;

  @override
  void initState() {
    super.initState();
    menstrualCycleLength = widget.menstrualCycleLength;
  }

  @override
  void didUpdateWidget(CycleLengthValueText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menstrualCycleLength != oldWidget.menstrualCycleLength) {
      setState(() {
        menstrualCycleLength = widget.menstrualCycleLength;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$menstrualCycleLength',
      style: TextStyle(color: buttonColor, fontSize: 30),
    );
  }
}
