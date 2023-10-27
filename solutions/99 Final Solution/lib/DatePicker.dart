import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // For days of the week
import 'state.dart';

class DatePicker extends ConsumerStatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends ConsumerState<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final _selectedDate = ref.watch(selectedDateProvider);
    print("selectedDate $_selectedDate");
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
        ),
        //   fit: FlexFit.tight,
        //   flex: 1,
        // ),
        onPressed: () {
          ref.read(selectedDateProvider.notifier).set(date);
        },
      );
    }).toList();
  }
}
