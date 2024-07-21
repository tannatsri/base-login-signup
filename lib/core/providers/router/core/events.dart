

import 'package:base_project/core/views/core/view/view.dart';

abstract class IRouterEvent {}


class RecreateViaLinkEvent extends IRouterEvent {
  final String link;

  RecreateViaLinkEvent({
    required this.link,
  });
}

class PushLinkEvent extends IRouterEvent {
  final String link;

  PushLinkEvent({
    required this.link,
  });
}

class NavigateToLinkEvent extends IRouterEvent {
  final String link;

  NavigateToLinkEvent({
    required this.link,
  });
}

class OpenLinkOnSplashEvent extends IRouterEvent {
  final String link;

  OpenLinkOnSplashEvent({
    required this.link,
  });
}

/// When`PopEvent` is added to the router, the top-most route is popped.
///
/// In the case that this route is the last route on the stack, the entire
/// [ViewController] in the case of iOS, and the entire [Activity] in the case
/// of Android containing this FlutterInstance is popped/dismissed as the case
/// may be.
class PopEvent extends IRouterEvent {
  final bool isSuperPop;
  PopEvent({
    required this.isSuperPop,
  });
}

class PopPageWithIdEvent extends IRouterEvent {
  final String pageId;
  PopPageWithIdEvent({
    required this.pageId,
  });
}

class BottomSheetVisibilityEvent extends IRouterEvent {
  final bool isVisible;
  final bool isPersistentBottomSheet;
  BottomSheetVisibilityEvent({
    required this.isVisible,
    required this.isPersistentBottomSheet,
  });
}

class ModalDialogVisibilityEvent extends IRouterEvent {
  final bool isVisible;

  ModalDialogVisibilityEvent({
    required this.isVisible,
  });
}

class UnknownPathEvent extends IRouterEvent {
  final String path;
  final IViewParameters parameters;

  UnknownPathEvent({
    required this.path,
    required this.parameters,
  });
}

class UnknownLinkEvent extends IRouterEvent {
  final String link;

  UnknownLinkEvent({
    required this.link,
  });
}
