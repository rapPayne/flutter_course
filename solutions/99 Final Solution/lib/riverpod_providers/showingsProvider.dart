import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ShowingsProvider extends StateNotifier<List<dynamic>> {
  _ShowingsProvider() : super([]);
  void set(List<dynamic> showings) {
    state = showings;
  }
}

final showingsProvider =
    StateNotifierProvider<_ShowingsProvider, List<dynamic>>(
        (ref) => _ShowingsProvider());
