import 'package:flutter/material.dart';

/// To use this
/// 1) pub get package
/// 2) import 'package:superstate.dart'; Wherever needed.
///
/// In main ...
///
/// 3) Author your AppState class with any sub-classes you like.
/// class AppState { String? prop1; SomeClass?: prop2; } class SomeClass { etc. }
/// 4) Instantiate your initial AppState object .
/// AppState _state = AppState()..prop1='foo'..prop2=SomeClass();
/// 5) Wrap your main widget with SuperStateWidget.
/// build(context) {
/// return SuperStateWidget<AppState>(
///  initialState: _state;
///  child: Text("hello world")
/// );}
///
/// Later, in any child widget...
///
/// To read a state variable
/// class SomeWidget extends Stateful/StatelessWidget {
///  build(context) {
///   AppState state = SuperState.of(context).appState.state;
///   String prop1 = state.prop1;
///   SomeClass foo = state.prop2;
///  }
/// }
///
/// To update a state variable and have it re-render with these values:
/// AppState newState = AppState();
/// // Set the properties of your new state object however you like.
/// SuperState.of(context).change(newState));
///
/// SuperState is the Root Widget
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
  late StateWrapper<T> stateWrapper;

  @override
  void initState() {
    stateWrapper = widget.stateWrapper as StateWrapper<T>;
    super.initState();
  }

  void change(T newState) {
    setState(() {
      stateWrapper = StateWrapper<T>(state: newState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SuperStateInheritedWidget(
      stateWidget: this,
      state: stateWrapper,
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
