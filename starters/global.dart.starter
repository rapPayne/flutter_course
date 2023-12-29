Global global = Global();

class Global {
  Global();
  final Map<String, dynamic> _global = {};

  T get<T>(String key) {
    assert(_global[key] != null, "$key is null");
    return _global[key] as T;
  }

  T? maybeGet<T>(String key) {
    return _global[key] as T;
  }

  void set(String key, dynamic value) {
    _global[key] = value;
  }
}
