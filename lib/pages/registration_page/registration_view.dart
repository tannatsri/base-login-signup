import 'package:base_project/pages/registration_page/repository/registration_repository.dart';
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
import 'controller/registration_view_controller.dart';
import 'controller/registration_view_states.dart';

class RegistrationViewParameters extends IViewParameters {
  RegistrationViewParameters();

  RegistrationViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class RegistrationView
    extends IView<RegistrationViewParameters, RegistrationViewController> {
  RegistrationView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => RegistrationViewController(
            RegistrationViewState.initial(),
            repository: RegistrationRepository(
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
                                  text: "Hello! Register to get started",
                                  color: "#191c1f",
                                  font: "h2",
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
                            inputType: InputType.text,
                            hintText: 'Username',
                            key: 'username'
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValidationMap(key, value);
                              }
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                            inputType: InputType.email,
                            hintText: 'Email',
                            key: 'email'
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValidationMap(key, value);
                              }
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                            inputType: InputType.password,
                            hintText: 'Password',
                            key: 'password'
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValidationMap(key, value);
                              }
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                            inputType: InputType.password,
                            hintText: 'Confirm Password',
                            key: 'confirm_password'
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<RegistrationViewController>().updateValidationMap(key, value);
                              }
                          ),
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
                                    text: "Register",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context.read<RegistrationViewController>().onRegisterNowTap(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextImageSpanWidget(
                    data: TextImageSpanWidgetData(
                      alignment: "center",
                      list: [
                        TextImageSpanWidgetItemData(
                          type: "text",
                          title: BaseTextData(
                            text: "Already have an account?",
                            color: "#757579",
                            font: "caption",
                          ),
                        ),
                        TextImageSpanWidgetItemData(
                          type: "text-cta",
                          title: BaseTextData(
                            text: " Login Now ",
                            color: "#42f2f5",
                            font: "caption",
                          ),
                          button: BaseButtonData(type: ""),
                        ),
                      ],
                    ),
                    onClickListener: (cta) {},
                  ),
                ],
              ),
            ),
          ),
        );
}
