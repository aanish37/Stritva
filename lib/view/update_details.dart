import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';

DateTime _recentPeriodDate = DateTime.now();

class PeriodInfo {
  int cycleLength;
  DateTime recentPeriodDate;
  int periodLength;

  PeriodInfo(this.cycleLength, this.recentPeriodDate, this.periodLength);
}

class EditPeriodInfoScreen extends StatefulWidget {
  @override
  _EditPeriodInfoScreenState createState() => _EditPeriodInfoScreenState();
}

class _EditPeriodInfoScreenState extends State<EditPeriodInfoScreen> {
  TextEditingController _cycleLengthController = TextEditingController();
  DateTime _recentPeriodDate = DateTime.now();
  TextEditingController _periodLengthController = TextEditingController();
  PeriodInfo _periodInfo = PeriodInfo(28, DateTime.now(), 5); // Initial data

  @override
  void initState() {
    super.initState();
    _cycleLengthController.text = _periodInfo.cycleLength.toString();
    _periodLengthController.text = _periodInfo.periodLength.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _recentPeriodDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _recentPeriodDate)
      setState(() {
        _recentPeriodDate = picked;
      });
  }

  void _saveChanges() {
    setState(() {
      _periodInfo.cycleLength = int.tryParse(_cycleLengthController.text) ?? 28;
      _periodInfo.recentPeriodDate = _recentPeriodDate;
      _periodInfo.periodLength =
          int.tryParse(_periodLengthController.text) ?? 5;
    });
    // You can save the updated period info to your database or perform other actions here
    // For now, we'll just print the updated data
    print("Updated Period Info:");
    print("Cycle Length: ${_periodInfo.cycleLength}");
    print("Recent Period Date: ${_periodInfo.recentPeriodDate}");
    print("Period Length: ${_periodInfo.periodLength}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Edit Period Info"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _cycleLengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusColor: buttonColor,
                labelText: "Cycle Length (days)",
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: "${_recentPeriodDate.toLocal()}".split(' ')[0]),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
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
            SizedBox(height: 16),
            TextFormField(
              controller: _periodLengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Period Length (days)",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
