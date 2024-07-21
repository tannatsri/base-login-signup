import 'package:base_project/pages/login_page/repository/login_repository.dart';
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
import 'controller/login_view_controller.dart';
import 'controller/login_view_states.dart';

class LoginViewParameters extends IViewParameters {
  LoginViewParameters();

  LoginViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class LoginView extends IView<LoginViewParameters, LoginViewController> {
  LoginView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => LoginViewController(
            LoginViewState.initial(),
            repository: LoginRepository(
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
                                  text: "Welcome back! Glad to see you, Again!",
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
                            inputType: InputType.email,
                            hintText: 'Enter your email',
                            key: 'email',
                          ),
                          genericCallBackList: GenericCallBackList(
                            onKeyValueChangeListener: (key, value) {
                              context.read<LoginViewController>().updateValueMap(key, value);
                            },
                            onValidationChangeListener: (key, value) {
                              context.read<LoginViewController>().updateValidationMap(key, value);
                            }
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        BaseInputWidget(
                          data: BaseInputWidgetData(
                            inputType: InputType.password,
                            hintText: 'Enter password',
                            key: "password"
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<LoginViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<LoginViewController>().updateValidationMap(key, value);
                              }
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                        TextImageSpanWidget(
                          data: TextImageSpanWidgetData(
                            alignment: "top-right",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text-cta",
                                title: BaseTextData(
                                  text: "Forgot Password?",
                                  color: "#757579",
                                  font: "caption",
                                ),
                                button: BaseButtonData(type: ""),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {
                            context.read<LoginViewController>().onForgotPasswordTap(context);
                          },
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
                                    text: "Login",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context.read<LoginViewController>().validateInputField(context);
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
                            text: "Don't have an account? ",
                            color: "#757579",
                            font: "caption",
                          ),
                        ),
                        TextImageSpanWidgetItemData(
                            type: "text-cta",
                            title: BaseTextData(
                              text: "Register Now ",
                              color: "#42f2f5",
                              font: "caption",
                            ),
                            button: BaseButtonData(type: "")),
                      ],
                    ),
                    onClickListener: (cta) {
                      context.read<LoginViewController>().onSignUpTap(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
}
