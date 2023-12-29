import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.setSelectedDate});
  final void Function(DateTime) setSelectedDate;

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates =
        makeConsecutiveDates(startDate: DateTime.now(), howMany: 5);

    return Column(
      children: dates
          .map((date) => TextButton(
                onPressed: () => setSelectedDate(date),
                child: Text(DateFormat(DateFormat.WEEKDAY).format(date)),
              ))
          .toList(),
    );
  }
}
