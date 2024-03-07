class Person {
  Person({
    this.first = '',
    this.last = '',
    this.age = 0,
  });
  String first;
  String last;
  int age;

  @override
  String toString() {
    return '${super.toString()} $first $last';
  }

  Person copyWith({
    String? first,
    String? last,
    int? age,
  }) {
    return Person(
      first: first ?? this.first,
      last: last ?? this.last,
      age: age ?? this.age,
    );
  }
}
