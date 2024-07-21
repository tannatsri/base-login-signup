import 'package:base_project/core/providers/router/core/registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/view_controller.dart';

typedef ViewControllerCreator<T extends IViewController> = T Function(BuildContext context);

abstract class IViewParameters {
  IViewParameters();

  IViewParameters.from(LinkParameters parameters);

  Map<String, dynamic> toJson();
}

typedef OnBackPressedCallback = Function(BuildContext context);
typedef BackPressedCallback = Function();

//ignore: must_be_immutable
abstract class IView<ViewParameters extends IViewParameters, ViewController extends IViewController>
    extends StatelessWidget {
  final ViewControllerCreator<ViewController> creator;
  ViewController? viewController;
  final WidgetBuilder builder;
  final ViewParameters parameters;

  IView({
    Key? key,
    required this.parameters,
    required this.creator,
    required this.builder,
  }) : super(key: key);

  /// Return [true] to make it non blocking.
  ///
  /// Return [false] to make it blocking.
  ///
  /// Blocking means that navigator will not perform any related action.
  ///
  /// This function is called when the user presses the back button or the page is about to pop.
  /// i.e. the page is getting about to be removed from the stack.
  bool onBackPressed() {
    return true;
  }

  /// Return [true] to make it non blocking.
  ///
  /// Return [false] to make it blocking.
  ///
  /// Blocking means that navigator will not perform any related action.
  ///
  /// This function is called when the page is about to again visible on screen.
  /// i.e. the page is getting to stack top.
  bool onResume() {
    return true;
  }

  /// Return [true] to make it non blocking.
  ///
  /// Return [false] to make it blocking.
  ///
  /// Blocking means that navigator will not perform any related action.
  ///
  /// This function is called when the page is moved from stack top to a below page.
  /// i.e. the visibility of page is changed.
  bool onPause() {
    return true;
  }

  /// Return [true] to make it non blocking.
  ///
  /// Return [false] to make it blocking.
  ///
  /// Blocking means that navigator will not perform any related action.
  ///
  /// This function is called when the page is about to popped from stack.
  /// i.e. the page is getting removed from the stack.
  void onDestroy() {}

  @override
  Widget build(BuildContext context) => BlocProvider<ViewController>(
        create: (context) {
          final controller = creator(context);
          viewController = controller;
          return controller;
        },
        child: Builder(
          builder: (context) => builder(context),
        ),
      );
}
