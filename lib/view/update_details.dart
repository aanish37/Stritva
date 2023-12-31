import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';
import '../model/user_data.dart';
import 'package:provider/provider.dart';

class EditPeriodInfoScreen extends StatefulWidget {
  const EditPeriodInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditPeriodInfoScreenState createState() => _EditPeriodInfoScreenState();
}

class _EditPeriodInfoScreenState extends State<EditPeriodInfoScreen> {
  final TextEditingController _cycleLengthController = TextEditingController();
  final TextEditingController _periodLengthController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var _recentPeriodDate = DateTime(2000, 10, 31);
  final newDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: newDate,
      firstDate: DateTime(2000),
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
    final user = Provider.of<UserData>(context, listen: false).user;
    final cycleLength = user.cycleLength;
    final periodLegth = user.periodLength;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Edit Period Info"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
            ),
            onPressed: () {
              if (_cycleLengthController.text.isEmpty) {
                _cycleLengthController.text = cycleLength.toString();
              }
              if (_periodLengthController.text.isEmpty) {
                _periodLengthController.text = periodLegth.toString();
              }
              if (_recentPeriodDate == DateTime(2000, 10, 31)) {
                _recentPeriodDate = user.recentPeriodDate;
              }

              Provider.of<UserData>(context, listen: false)
                  .addCycleLength(int.parse(_cycleLengthController.text));
              Provider.of<UserData>(context, listen: false)
                  .addPeriodLength(int.parse(_periodLengthController.text));

              Provider.of<UserData>(context, listen: false)
                  .addRecentPeriodDate(_recentPeriodDate);
              Navigator.pop(context);
            },
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            TextFormField(
              controller: _periodLengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Period Length (days)",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
