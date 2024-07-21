import 'package:base_project/common/base_components/base_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/login_repository.dart';
import 'login_view_events.dart';
import 'login_view_states.dart';

class LoginViewController
    extends IViewController<LoginViewEvent, LoginViewState, LoginRepository> {
  LoginViewController(
    super.initialState, {
    required super.repository,
    required super.router,
  });

  Map<String, bool> validationMap = {};

  Map<String, String> valueMap = {};

  void updateValueMap(String? key, String? value) {
    if (key == null || value == null) return;
    valueMap[key] = value;
  }

  void updateValidationMap(String? key, bool? value) {
    if (key == null || value == null) return;
    validationMap[key] = value;
  }

  bool _isAllInputValid() {
    return !validationMap.containsValue(false);
  }

  void onSignUpTap(BuildContext context) {
    router.navigateToLink(
        "https://www.tannatsri.com/registration?fromLogin=true");
  }

  void validateInputField(BuildContext context) {
    if (_isAllInputValid()) {
      router.navigateToLink("https://www.tannatsri.com/password-success");
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
              text: "Enter correct values", color: "#ffffff", font: "caption"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onForgotPasswordTap(BuildContext context) {
    router.navigateToLink("https://www.tannatsri.com/forgot-password");
  }
}
