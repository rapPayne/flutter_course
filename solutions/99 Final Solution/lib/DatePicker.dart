import 'package:daam/state/AppState.dart';
import 'package:daam/state/SuperState.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For days of the week
// import 'state.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late SuperState _ss;

  @override
  void didChangeDependencies() {
    // Get state
    _ss = SuperState.of(context);
    _ss.addListener(() {
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //print("selectedDate ${_state.selectedDate.toString()}");
    return Container(
      child: Wrap(
        children: _getDates(),
        alignment: WrapAlignment.spaceBetween,
      ),
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
            style: date == _ss.state.selectedDate
                ? TextStyle(fontWeight: FontWeight.bold)
                : TextStyle(fontWeight: FontWeight.normal),
          ),
          //   fit: FlexFit.tight,
          //   flex: 1,
          // ),
          onPressed: () {
            AppState newState = _ss.state;
            newState.selectedDate = date;
            _ss.setState(newState);
          });
    }).toList();
  }
}
