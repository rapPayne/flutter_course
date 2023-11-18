import 'package:flutter/material.dart';

/// To use this
/// 1) pub get package
/// 2) import 'package:SuperState.dart'; Wherever needed.
///
/// In main ...
///
/// 3) Create your AppState class with any sub-classes you like.
/// class AppState { String? prop1; prop2?: SomeClass; } class SomeClass { etc. }
/// 4) Instantiate your initial AppState object .
/// AppState _state = AppState()..prop1='foo'..prop2=SomeClass();
/// 5) Wrap your main widget with SuperStateWidget.
/// build(context) {
/// return SuperStateWidget<AppState>(
///  state: _state;
///  child: Text("hello world")
/// );}
///
/// Later, in any child widget...
///
/// To read a state variable
/// class SomeWidget extends Stateful/StatelessWidget {
///  build(context) {
///   SuperState<AppState> _ss = SuperState.of(context); ???
///   AppState _localStateCopy = _ss.state;
///   String prop1 = _localStateCopy.prop1;
///   SomeClass foo = _localStateCopy.prop2;
///  }
/// }
///
/// To update a state variable and have it re-render with these values:
/// SuperState<AppState> _ss = SuperState.of(context);
/// _ss.setState({...oldState, prop1: "newString", prop2: newObject});

/// The Widget wrapper class
///
/// @param child The child widget that will be displayed
/// @param state User-defined and user-provided state object
class SuperStateWidget extends StatefulWidget {
  late final SuperState superStateObject;
  late final _SuperStateInheritedWidget superStateInheritedWidget;
  final Widget child;
  final dynamic state;

  SuperStateWidget({Key? key, required this.child, required this.state})
      : super(key: key) {
    superStateInheritedWidget =
        _SuperStateInheritedWidget(state: state, child: child);
    superStateObject = SuperState.create(state: state);
  }

  @override
  State<SuperStateWidget> createState() => _SuperStateWidgetState();
}

class _SuperStateWidgetState extends State<SuperStateWidget> {
  @override
  void initState() {
    // TODO: set up the object (with accessors), the notifier
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('rebuilding...');
    //widget.superStateObject.addListener(_modelChanged);
    return widget.superStateInheritedWidget;
  }

  @override
  void dispose() {
    //widget.superStateObject.removeListener(_modelChanged);
    super.dispose();
  }
}

/// The root class exposed. All access to state will be done through this widget.
///
///
class SuperState extends ChangeNotifier {
  // Static things
  /// The singleton instance. Internally it is of type dynamic but externally is of type T.
  static SuperState? singletonInstance;

  static SuperState create({required dynamic state}) {
    assert(SuperState.singletonInstance == null,
        'Create has already been called. It should only ever be called once, and only by the framework, never by the user.');
    // Call the private constructor and put it in static singletonInstance.
    SuperState.singletonInstance = new SuperState._(state: state);
    return SuperState.singletonInstance!;
  }

  /// Way to get access to the inheritedWidget. It is on the
  /// SuperState object since the inheritedWidget is encapsulated
  /// and never needs to be accessed directly.
  static SuperState? maybeOf(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<_SuperStateInheritedWidget>();
    return SuperState.singletonInstance;
  }

  /// Way to get access to the inheritedWidget. It is on the
  /// SuperState object since the inheritedWidget is encapsulated
  /// and never needs to be accessed directly.
  static SuperState of(BuildContext context) {
    final SuperState? result = SuperState.maybeOf(context);
    assert(result != null, "No SuperState widget found in context");
    return result!;
  }

  // Instance things
  dynamic state;
  // late _SuperStateNotifier superStateNotifier;

  SuperState._({required dynamic this.state});

  void setState(dynamic newState) {
    state = newState;
    notifyListeners();
  }
}

/// Another private class that exists to notify descendents to
/// rerender themselves because something has changed.
// class _SuperStateNotifier extends ChangeNotifier {
//   dynamic state;

//   // Update the state here
//   void setState(dynamic newState) {
//     state = newState;
//     notifyListeners();
//   }

//   // /// Simply calls notifyListeners().
//   // void notify() {
//   //   notifyListeners();
//   // }
// }

class _SuperStateInheritedWidget extends InheritedWidget {
  final dynamic state;
  _SuperStateInheritedWidget({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_SuperStateInheritedWidget oldWidget) {
    return oldWidget.state != state;
  }

  static _SuperStateInheritedWidget of(BuildContext context) {
    _SuperStateInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_SuperStateInheritedWidget>();
    assert(result != null, "No SuperState widget found in context");
    return result!;
  }
}
