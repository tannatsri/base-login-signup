

import 'package:base_project/pages/splash_page/controller/splash_view_events.dart';
import 'package:base_project/pages/splash_page/controller/splash_view_states.dart';

import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/splash_repository.dart';

class SplashViewController extends IViewController<SplashViewEvent, SplashViewState, SplashRepository> {
  SplashViewController(
    super.initialState, {
    required super.repository,
    required super.router,
  });
  
  
  void onLoginTap() {
    router.navigateToLink("https://www.tannatsri.com/login");
  }

  void onSignUpTap() {
    router.navigateToLink("https://www.tannatsri.com/registration");
  }
}
