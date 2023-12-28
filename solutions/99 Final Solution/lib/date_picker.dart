// import 'package:daam/state/app_state.dart';
// import 'package:daam/state/superState.dart';
import 'package:daam/state/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For days of the week

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = global.get<DateTime>("selectedDate");
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: _getDates(),
    );
  }

  List<Widget> _getDates() {
    // Create a 5-member List<DateTime> starting with today
    DateTime now = DateTime.now();
    DateTime today = DateTime.utc(now.year, now.month, now.day);
    List<DateTime> dates =
        List<DateTime>.generate(5, (i) => today.add(Duration(days: i)));
    return dates.map<Widget>((date) {
      String text = DateFormat(DateFormat.WEEKDAY).format(date);
      return TextButton(
          // child: Flexible(
          child: Text(
            text,
            style: date == selectedDate
                ? const TextStyle(fontWeight: FontWeight.bold)
                : const TextStyle(fontWeight: FontWeight.normal),
          ),
          //   fit: FlexFit.tight,
          //   flex: 1,
          // ),
          onPressed: () {
            global.set("selectedDate", date);
            Navigator.pushNamed(context,
                '/'); // Kludgey way to get showing times to repopulate.
          });
    }).toList();
  }
}
