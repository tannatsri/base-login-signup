
import 'dart:io' as io;

import 'package:base_project/common/extension/list.dart';
import 'package:base_project/core/providers/router/core/events.dart';
import 'package:base_project/core/providers/router/core/registry.dart';
import 'package:base_project/core/providers/router/core/states.dart';
import 'package:base_project/core/views/core/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class IRouter extends Bloc<IRouterEvent, IRouterState> {
  final IRouteRegistry registry;
  final navigationChannel = const MethodChannel('navigation.indmoney_channel');

  IRouter(
    super.initialState, {
    required this.registry,
  }) {
    on<IRouterEvent>(
      (event, emit) {
        switch (event.runtimeType) {
          case RecreateViaLinkEvent:
            _onRecreateViaLink(
              event: event as RecreateViaLinkEvent,
              emit: emit,
            );

            break;

          case PushLinkEvent:
            _onPushLink(
              event: event as PushLinkEvent,
              emit: emit,
            );

            break;
          case NavigateToLinkEvent:
            _onNavigateToLink(
              event: event as NavigateToLinkEvent,
              emit: emit,
            );
            break;

          case OpenLinkOnSplashEvent:
            _onOpenLinkOnSplash(
              event: event as OpenLinkOnSplashEvent,
              emit: emit,
            );
            break;

          case PopEvent:
            _onPop(
              event: event as PopEvent,
              emit: emit,
            );

            break;
        }
      },
    );
  }

  void recreateViaLink(String link) {
    final recreateLinkEvent = RecreateViaLinkEvent(link: link);

    add(recreateLinkEvent);
  }

  void pushLink(String link) {
    final pushLinkEvent = PushLinkEvent(
      link: link,
    );

    add(pushLinkEvent);
  }

  void openNavFromDashboard(String link) {}

  void shareToExternalApp(String data) {}

  void navigateToLink(String link) {
    final navigateLinkEvent = NavigateToLinkEvent(
      link: link,
    );

    add(navigateLinkEvent);
  }

  void openLinkOnSplash(String link) {
    final openLinkOnSplashEvent = OpenLinkOnSplashEvent(
      link: link,
    );

    add(openLinkOnSplashEvent);
  }

  void openLinkAsRoot(String link) {
    final openLinkOnSplashEvent = OpenLinkOnSplashEvent(
      link: link,
    );

    add(openLinkOnSplashEvent);
  }

  /// This function checks whether we have to pop page from flutter page stack or from Android/IOS activity stack.
  /// This returns true if we have to pop it from flutter stack or else false.
  bool isValidFlutterPop() {
    if (state.pages.length > 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isBottomSheetVisible() {
    return state.isBottomSheetVisible;
  }

  bool isModalDialogVisible() {
    return state.isModalDialogVisible;
  }

  bool isPersistentBottomSheet() {
    return state.isPersistentBottomSheet;
  }

  void hideBottomSheet({
    required BuildContext context,
    bool toClose = true,
    bool isPersistentBottomSheet = false,
  }) {
    if (state.isBottomSheetVisible && toClose) {
      setBottomSheetVisibility(
          isVisible: false, isPersistentBottomSheet: isPersistentBottomSheet);
      Navigator.pop(context);
    } else if (state.isBottomSheetVisible && toClose == false) {
      setBottomSheetVisibility(
          isVisible: false, isPersistentBottomSheet: isPersistentBottomSheet);
    }
  }

  void hideModalDialog({required BuildContext context}) {
    if (state.isModalDialogVisible) {
      Navigator.pop(context);
      setModalDialogVisibility(isVisible: false);
      if (readFrom<IRouter>(context).isBottomSheetVisible()) {
        readFrom<IRouter>(context).hideBottomSheet(context: context);
      } else {
        readFrom<IRouter>(context).pop();
      }
    }
  }

  void showModalDialog() {
    setModalDialogVisibility(isVisible: true);
  }

  void showBottomSheet({
    required BuildContext context,
    bool isPersistentBottomSheet = false,
  }) {
    setBottomSheetVisibility(
        isVisible: true, isPersistentBottomSheet: isPersistentBottomSheet);
  }

  void setBottomSheetVisibility({
    required bool isVisible,
    required bool isPersistentBottomSheet,
  }) {
    final bottom = BottomSheetVisibilityEvent(
        isVisible: isVisible, isPersistentBottomSheet: isPersistentBottomSheet);
    add(bottom);
  }

  void setModalDialogVisibility({required bool isVisible}) {
    final bottom = ModalDialogVisibilityEvent(isVisible: isVisible);
    add(bottom);
  }

  void pop({bool? isSuperPop = false}) {
    final popEvent = PopEvent(isSuperPop: isSuperPop ?? false);

    add(popEvent);
  }

  void removePageWithId({required String pageId}) {
    final popEvent = PopPageWithIdEvent(pageId: pageId);

    add(popEvent);
  }

  void openDeeplinkOnRoute() {}

  void onUnknownPath({
    required String path,
    required IViewParameters parameters,
  }) {}

  void onUnknownLink({
    required String link,
  }) {}

  void _onRecreateViaLink({
    required RecreateViaLinkEvent event,
    required Emitter<IRouterState> emit,
  }) {
    final route = registry.routeWhichCanSatisfyLink(event.link);

    if (route != null) {
      final parameters = event.link.linkParameters(
        prefix: route.path,
      );

      final page = route.pageFromLink(
        parameters: parameters,
      );

      final updatedState = state.copyWith(
        pages: [page],
      );

      emit(updatedState);
    } else {
      final unknownLinkEvent = UnknownLinkEvent(
        link: event.link,
      );

      add(unknownLinkEvent);
    }
  }

  IndPage? _getStackTopPage() {
    try {
      return state.pages.last;
    } catch (e) {
      return null;
    }
  }

  void _onPushLink({
    required PushLinkEvent event,
    required Emitter<IRouterState> emit,
  }) {
    final stackTopPage = _getStackTopPage();

    final onPauseCallBack = stackTopPage?.child.onPause();
    if (onPauseCallBack == true) {
      final route = registry.routeWhichCanSatisfyLink(event.link);

      if (route != null) {
        final parameters = event.link.linkParameters(
          prefix: route.path,
        );

        final page = route.pageFromLink(
          parameters: parameters,
        );

        final updatedState = state.copyWith(
          pages: [
            ...state.pages,
            page,
          ],
        );

        emit(updatedState);
      } else {
        final unknownLinkEvent = UnknownLinkEvent(
          link: event.link,
        );

        add(unknownLinkEvent);
      }
    }
  }

  void _onNavigateToLink({
    required NavigateToLinkEvent event,
    required Emitter<IRouterState> emit,
  }) {
    final stackTopPage = _getStackTopPage();

    final onPauseCallBack = stackTopPage?.child.onPause();
    if (onPauseCallBack == true) {
      final route = registry.routeWhichCanSatisfyLink(event.link);

      if (route != null) {
        final pushEvent = PushLinkEvent(
          link: event.link,
        );

        add(pushEvent);
      } else {
        final unknownLinkEvent = UnknownLinkEvent(
          link: event.link,
        );

        add(unknownLinkEvent);
      }
    }
  }

  void _onOpenLinkOnSplash({
    required OpenLinkOnSplashEvent event,
    required Emitter<IRouterState> emit,
  }) {
    final route = registry.routeWhichCanSatisfyLink(event.link);

    if (route != null) {
      final parameters = event.link.linkParameters(
        prefix: route.path,
      );

      final page = route.pageFromLink(
        parameters: parameters,
      );

      final updatedState = state.copyWith(
        pages: [
          ...state.pages.take(1),
          page,
        ],
      );

      emit(updatedState);

    }
  }

  void _onPop({
    required PopEvent event,
    required Emitter<IRouterState> emit,
  }) {
    final stackTopPage = _getStackTopPage();
    if (state.pages.length > 1) {
      if (event.isSuperPop == true) {
        stackTopPage?.child.onDestroy();
        final updatedState = state.copyWith(
          pages: state.pages.take(state.pages.length - 1).toList(),
        );
        emit(updatedState);
        return;
      } else {
        final onBackPressed = stackTopPage?.child.onBackPressed();
        if (onBackPressed == true) {
          stackTopPage?.child.onDestroy();
          final updatedState = state.copyWith(
            pages: state.pages.take(state.pages.length - 1).toList(),
          );
          emit(updatedState);
        } else {
          return;
        }
      }
    } else {
      final onBackPressed = stackTopPage?.child.onBackPressed();
      if (onBackPressed == true) {
        stackTopPage?.child.onDestroy();
        if (io.Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (io.Platform.isIOS) {
          io.exit(0);
        }
      } else {
        return;
      }
    }
  }
}

class MainRouter extends IRouter {
  MainRouter({
    required MainRouteRegistry registry,
  }) : super(
          IRouterState.initialFrom(
              registry: registry,
              isBottomSheetVisible: false,
              isModalDialogVisible: false,
              isPersistentBottomSheet: false),
          registry: registry,
        ) {
    _prepareNavigationChannel();
  }

  void _prepareNavigationChannel() {
    navigationChannel.setMethodCallHandler(
      (call) async {
        final method = call.method;
        final arguments = call.arguments;

        switch (method) {
          case 'initialRoute':
            final link = arguments as String;

            recreateViaLink(link);

            break;
          default:
            throw UnimplementedError('Unimplemented');
        }
      },
    );
  }

  @override
  void pop({bool? isSuperPop = false}) {
    if (state.pages.length == 1) {
      if (isSuperPop == true) {
        navigationChannel.invokeMethod('pop');
        return;
      } else {
        super.pop(isSuperPop: isSuperPop);
      }
    } else {
      super.pop(isSuperPop: isSuperPop);
    }
  }
}

extension on String {
  LinkParameters linkParameters({
    required String prefix,
  }) {
    final List<String> pathParameters = [];
    final Map<String, String> queryParameters = {};

    final matches = prefix.allMatches(this);

    if (matches.isNotEmpty) {
      final route = substring(matches.first.end);

      final segments = route.split('?');

      final pathSegment = segments.at(0);

      if (pathSegment != null && pathSegment.isNotEmpty) {
        final pathSegments = pathSegment.split('/');

        for (final pathSegment in pathSegments) {
          if (pathSegment.isNotEmpty) {
            pathParameters.add(pathSegment);
          }
        }
      }

      final querySegment = segments.at(1);

      if (querySegment != null && querySegment.isNotEmpty) {
        final querySegments = querySegment.split("&");

        for (final querySegment in querySegments) {
          if (querySegment.isNotEmpty) {
            final segments = querySegment.split('=');

            final key = segments.at(0);
            final value = segments.at(1);

            if (key != null &&
                value != null &&
                key.isNotEmpty &&
                value.isNotEmpty) {
              queryParameters[key] = value;
            }
          }
        }
      }
    }

    final parameters = LinkParameters(
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );

    return parameters;
  }
}

T readFrom<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}

T watchFrom<T>(BuildContext context) {
  return Provider.of<T>(context, listen: true);
}
