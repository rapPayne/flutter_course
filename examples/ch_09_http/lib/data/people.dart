import 'package:http/http.dart';

import '../types/person.dart';

const String _baseUrl = 'https://jsonplaceholder.typicode.com';

Future<Response> fetchPeople() {
  Uri uri = Uri.parse(Uri.encodeFull('$_baseUrl/users'));
  return get(uri);
}

Future<Response> upsertPerson(Person person) {
  final String payload = """
  {
    "id": ${person.id},
    "name":"${person.name}",
    "phone":"${person.phone}",
    "email":"${person.email}"
  }
  """;
  final headers = {'Content-type': 'application/json'};
  // If id is null, we're adding. If not, we're updating.
  if (person.id == null) {
    Uri uri = Uri.parse('$_baseUrl/people');
    return post(uri, headers: headers, body: payload);
  } else {
    Uri uri = Uri.parse('$_baseUrl/people/${person.id}');
    return put(uri, headers: headers, body: payload);
  }
}

Future<Response> deletePerson(person) {
  Uri uri = Uri.parse('$_baseUrl/users/${person.id}');
  return delete(uri);
}
