import 'package:flutter/material.dart';

import '../../../common/base_components/base_text_widget.dart';
import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/forgot_password_repository.dart';
import 'forgot_password_view_events.dart';
import 'forgot_password_view_states.dart';

class ForgotPasswordViewController extends IViewController<
    ForgotPasswordViewEvent,
    ForgotPasswordViewState,
    ForgotPasswordRepository> {
  ForgotPasswordViewController(
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

  void onPop() {
    router.pop();
  }

  void navigateToOTPPage(BuildContext context) {
    if (_isAllInputValid()) {
      router.navigateToLink("https://www.tannatsri.com/otp-verification");
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
}
