import 'dart:convert' show jsonDecode;

class Person {
  Person({this.id, this.name, this.email, this.phone});
  int? id;
  String? name;
  String? email;
  String? phone;

  // The typed deserialization pattern for a single person
  static Person fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Person(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'email': email, 'name': name, 'phone': phone};

  // The typed deserialization pattern for a List
  static List<Person> fromJsonArray(String jsonString) {
    List<dynamic> json = jsonDecode(jsonString);
    return json
        .map((p) => Person(
            id: p['id'], email: p['email'], name: p['name'], phone: p['phone']))
        .toList();
  }
}
