import 'package:flutter/material.dart';

import '../../../common/base_components/base_text_widget.dart';
import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/registration_repository.dart';
import 'registration_view_events.dart';
import 'registration_view_states.dart';

class RegistrationViewController extends IViewController<RegistrationViewEvent,
    RegistrationViewState, RegistrationRepository> {
  RegistrationViewController(
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

  void onRegisterNowTap(BuildContext context) {
    if (_isAllInputValid() &&
        valueMap['password'] == valueMap['confirm_password']) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
            text: "Registration Successfull",
            color: "#ffffff",
            font: "caption",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (_isAllInputValid() == false) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
            text: "Please enter correct values",
            color: "#ffffff",
            font: "caption",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
            text: "Password doesn't match with confirm password values.",
            color: "#ffffff",
            font: "caption",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
