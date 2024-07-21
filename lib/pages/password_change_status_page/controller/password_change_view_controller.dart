import 'package:base_project/pages/password_change_status_page/controller/password_change_view_events.dart';
import 'package:base_project/pages/password_change_status_page/controller/password_change_view_states.dart';
import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/password_change_repository.dart';

class PasswordChangeViewController extends IViewController<
    PasswordChangeViewEvent,
    PasswordChangeViewState,
    PasswordChangeRepository> {
  PasswordChangeViewController(
    super.initialState, {
    required super.repository,
    required super.router,
  });

  void navigateToLoginScreen() {
    router.openLinkOnSplash("https://www.tannatsri.com/login");
  }
}
