import 'package:daam/state/showing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SelectedShowingProvider extends StateNotifier<Showing?> {
  _SelectedShowingProvider() : super(null);
  void set(Showing showing) {
    state = showing;
  }
}

final selectedShowingProvider =
    StateNotifierProvider<_SelectedShowingProvider, Showing?>(
        (ref) => _SelectedShowingProvider());
