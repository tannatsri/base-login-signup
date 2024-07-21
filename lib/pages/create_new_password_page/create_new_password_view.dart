import 'package:base_project/pages/create_new_password_page/repository/create_new_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/base_components/base_app_bar.dart';
import '../../common/base_components/base_button_widget.dart';
import '../../common/base_components/base_input_widget.dart';
import '../../common/base_components/base_scaffold.dart';
import '../../common/base_components/base_text_widget.dart';
import '../../common/base_components/text_image_span_widget.dart';
import '../../core/providers/router/core/router.dart';
import '../../core/views/core/view/view.dart';
import 'controller/create_new_password_view_controller.dart';
import 'controller/create_new_password_view_states.dart';

class CreateNewPasswordViewParameters extends IViewParameters {
  CreateNewPasswordViewParameters();

  CreateNewPasswordViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class CreateNewPasswordView extends IView<CreateNewPasswordViewParameters,
    CreateNewPasswordViewController> {
  CreateNewPasswordView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => CreateNewPasswordViewController(
            CreateNewPasswordViewState.initial(),
            repository: CreateNewPasswordRepository(
              networkAssistant: readFrom(context),
            ),
            router: readFrom(context),
          ),
          builder: (context) => BaseScaffold(
            appBar: const BaseAppBar(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextImageSpanWidget(
                          data: TextImageSpanWidgetData(
                            alignment: "top-left",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text: "Create new password",
                                  color: "#191c1f",
                                  font: "h2",
                                ),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {},
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextImageSpanWidget(
                          data: TextImageSpanWidgetData(
                            alignment: "top-left",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text:
                                      "Your new password must be unique from those previously used.",
                                  color: "#757779",
                                  font: "caption",
                                ),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {},
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                              inputType: InputType.password,
                              hintText: 'New password',
                              key: 'new_password'),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                            context
                                .read<CreateNewPasswordViewController>()
                                .updateValueMap(key, value);
                          }, onValidationChangeListener: (key, value) {
                            context
                                .read<CreateNewPasswordViewController>()
                                .updateValidationMap(key, value);
                          }),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                              inputType: InputType.password,
                              hintText: 'Confirm password',
                              key: 'confirm_password'),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                            context
                                .read<CreateNewPasswordViewController>()
                                .updateValueMap(key, value);
                          }, onValidationChangeListener: (key, value) {
                            context
                                .read<CreateNewPasswordViewController>()
                                .updateValidationMap(key, value);
                          }),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BaseButtonWidget(
                                data: BaseButtonData(
                                  title: BaseTextData(
                                    text: "Reset Password",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context
                                      .read<CreateNewPasswordViewController>()
                                      .navigateToPasswordSuccessScreen(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
