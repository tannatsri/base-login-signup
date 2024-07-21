import 'package:flutter/material.dart';

import '../../../common/base_components/base_text_widget.dart';
import '../../../core/views/core/view/controller/view_controller.dart';
import '../repository/create_new_password_repository.dart';
import 'create_new_password_view_events.dart';
import 'create_new_password_view_states.dart';

class CreateNewPasswordViewController extends IViewController<
    CreateNewPasswordViewEvent,
    CreateNewPasswordViewState,
    CreateNewPasswordRepository> {
  CreateNewPasswordViewController(
    super.initialState, {
    required super.repository,
    required super.router,
  });

  Map<String, bool> validationMap = {};

  Map<String, String> valueMap = {};


  void updateValueMap(String? key, String? value){
    if(key == null || value == null) return;
    valueMap[key] = value;
  }

  void updateValidationMap(String? key, bool? value){
    if(key == null || value == null) return;
    validationMap[key] = value;
  }

  bool _isAllInputValid() {
    return !validationMap.containsValue(false);
  }

  void navigateToPasswordSuccessScreen(BuildContext context) {
    if (_isAllInputValid() && valueMap['new_password'] == valueMap['confirm_password']) {
      router.openLinkOnSplash("https://www.tannatsri.com/password-success");
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: BaseTextWidget(
          data: BaseTextData(
              text: "New password doesn't match with confirm password values.", color: "#ffffff", font: "caption"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
