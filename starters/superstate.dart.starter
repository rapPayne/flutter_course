import 'package:flutter/material.dart';

/// The root class.
class SuperState<T> extends StatefulWidget {
  SuperState({
    super.key,
    required this.initialState,
    required this.child,
  }) : stateWrapper = StateWrapper<T>(state: initialState);

  final T initialState;
  final StateWrapper<T> stateWrapper;
  final Widget child;

  /// Gets a copy of the user's state object.
  static SuperStateState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SuperStateInheritedWidget>()!
        .stateWidget;
  }

  @override
  State<SuperState> createState() => SuperStateState();
}

/// Allows the user to mutate data and see the rerendered results.
class SuperStateState<T> extends State<SuperState> {
  late StateWrapper<T> appState;

  @override
  void initState() {
    appState = widget.stateWrapper as StateWrapper<T>;
    super.initState();
  }

  void change(T newState) {
    setState(() {
      appState = StateWrapper<T>(state: newState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SuperStateInheritedWidget(
      stateWidget: this,
      state: appState,
      child: widget.child,
    );
  }
}

/// Hidden. User never sees this.
class _SuperStateInheritedWidget extends InheritedWidget {
  const _SuperStateInheritedWidget({
    required this.stateWidget,
    required this.state,
    required super.child,
  });

  final SuperStateState stateWidget;
  final StateWrapper state;

  @override
  bool updateShouldNotify(_SuperStateInheritedWidget oldWidget) {
    return state != oldWidget.state;
  }
}

/// Holds a user-defined object<T> called state, which is the state of the app
@immutable
class StateWrapper<T> {
  const StateWrapper({required this.state});

  final T state;
}
