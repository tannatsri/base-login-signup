import 'package:flutter/material.dart';

import '../../../common/base_components/base_text_widget.dart';
import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/otp_verification_repository.dart';
import 'otp_verification_view_events.dart';
import 'otp_verification_view_states.dart';

class OtpVerificationViewController extends IViewController<
    OtpVerificationViewEvent,
    OtpVerificationViewState,
    OtpVerificationRepository> {
  OtpVerificationViewController(
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

  void onOTPTapPage(BuildContext context) {
    if (_isAllInputValid()) {
      if (valueMap['otp'] == '1234') {
        router.navigateToLink("https://www.tannatsri.com/new-password");
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          content: BaseTextWidget(
            data: BaseTextData(
              text: "Please enter correct OTP.",
              color: "#ffffff",
              font: "caption",
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
            text: "Please enter complete OTP.",
            color: "#ffffff",
            font: "caption",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void openRegistrationPage() {
    router.openLinkOnSplash("https://www.tannatsri.com/registration");
  }

  void showResendToast() {}
}
