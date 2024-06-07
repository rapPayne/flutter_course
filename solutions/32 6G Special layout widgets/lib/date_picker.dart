import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raw_state/raw_state.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.setSelectedDate});
  final void Function(DateTime) setSelectedDate;

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates =
        makeConsecutiveDates(startDate: DateTime.now(), howMany: 5);

    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: dates
          .map((date) => TextButton(
                onPressed: () {
                  rawState.set("selectedDate", date);
                  setSelectedDate(date);
                },
                child: Text(DateFormat(DateFormat.WEEKDAY).format(date)),
              ))
          .toList(),
    );
  }
}
