import 'package:base_project/core/providers/router/core/registry.dart';
import 'package:base_project/core/views/core/view/view.dart';
import 'package:flutter/material.dart';

class IRouterState {
   List<IndPage<dynamic>> pages;

  final bool isBottomSheetVisible;

  final bool isModalDialogVisible;

  final bool isPersistentBottomSheet;

   IRouterState({
    required this.pages,
    required this.isBottomSheetVisible,
    required this.isModalDialogVisible,
    required this.isPersistentBottomSheet,
  });

   IRouterState.initial([
    this.pages = const [],
    this.isBottomSheetVisible = false,
    this.isModalDialogVisible = false,
    this.isPersistentBottomSheet = false,
  ]);

  IRouterState.initialFrom({
    required IRouteRegistry registry,
    required this.isBottomSheetVisible,
    required this.isModalDialogVisible,
    required this.isPersistentBottomSheet,
  }) : pages = [
          if (registry.routes.any((route) => route.isInitialRoute))
            registry.routes
                .firstWhere((route) => route.isInitialRoute)
                .pageFromLink(
                  parameters: const LinkParameters.empty(),
                ),
        ];

  IRouterState copyWith({
    List<IndPage<dynamic>>? pages,
    bool? isBottomSheetVisible,
    bool? isModalDialogVisible,
    bool? isPersistentBottomSheet,
  }) =>
      IRouterState(
        pages: pages ?? this.pages,
        isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
        isModalDialogVisible: isModalDialogVisible ?? this.isModalDialogVisible,
        isPersistentBottomSheet:
            isPersistentBottomSheet ?? this.isPersistentBottomSheet,
      );
}

class IndPage<T> extends MaterialPage<T> {
  @override
  final IView child;

  const IndPage({
    required this.child,
    LocalKey? key,
    String? name,
    Object? arguments,
  }) : super(
          key: key,
          child: child,
          name: name,
          arguments: arguments,
        );
}
