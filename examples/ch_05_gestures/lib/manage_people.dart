import 'package:flutter/material.dart';
import 'person.dart';

class ManagePeople extends StatelessWidget {
  final List<Map<String, dynamic>> people;
  final Function deletePerson;
  final Function addPerson;
  final Function updatePerson;
  const ManagePeople(
      {super.key,
      required this.people,
      required this.addPerson,
      required this.deletePerson,
      required this.updatePerson});

  @override
  Widget build(BuildContext context) {
    double swipeStartX = 0;
    String swipeDirection = "";
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails e) {
        if (e.scale > 2.0) addPerson(context);
      },
      onDoubleTap: () => addPerson(context),
      child: ListView(
        children: people
            .map((Map<String, dynamic> person) => GestureDetector(
                  child: Person(person: person),
                  onLongPress: () {
                    deletePerson(person, context);
                  },
                  onHorizontalDragStart: (DragStartDetails e) {
                    swipeStartX = e.globalPosition.dx;
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails e) {
                    swipeDirection =
                        (e.globalPosition.dx > swipeStartX) ? "Right" : "Left";
                  },
                  onHorizontalDragEnd: (DragEndDetails e) {
                    if (swipeDirection == "Right") {
                      updatePerson(person, status: "nice");
                    } else {
                      updatePerson(person, status: "naughty");
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
