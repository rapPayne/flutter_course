import 'package:ch_09_http/data/people.dart';
import 'package:ch_09_http/types/person.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget(
      {super.key, required this.person, required this.editPerson});
  final Person person;
  final void Function() editPerson;
  final double _cellPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        onTap: editPerson,
        shape: Border.all(),
        leading: const Icon(
          Icons.person,
          size: 72,
        ),
        title: Center(child: Text(person.name ?? "")),
        subtitle: Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(1.0),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(_cellPadding),
                  child: const Icon(Icons.contact_phone_rounded),
                ),
                Padding(
                  padding: EdgeInsets.all(_cellPadding),
                  child: Text(person.phone ?? "No phone"),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(_cellPadding),
                  child: const Icon(Icons.contact_mail_rounded),
                ),
                Padding(
                  padding: EdgeInsets.all(_cellPadding),
                  child: Text(person.email ?? "No email"),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, size: 36),
          onPressed: () {
            bool goAheadAndDeletePerson = true;
            final SnackBar sb = SnackBar(
              content: Text("${person.name} was deleted"),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: "UNDO",
                onPressed: () => goAheadAndDeletePerson = false,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(sb);
            Future.delayed(const Duration(seconds: 5), () {
              if (goAheadAndDeletePerson) {
                deletePerson(person);
              }
            });
          },
        ),
      ),
    );
  }
}
