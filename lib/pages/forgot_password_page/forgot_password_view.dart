import 'package:base_project/pages/forgot_password_page/repository/forgot_password_repository.dart';
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
import 'controller/forgot_password_view_controller.dart';
import 'controller/forgot_password_view_states.dart';

class ForgotPasswordViewParameters extends IViewParameters {
  ForgotPasswordViewParameters();

  ForgotPasswordViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class ForgotPasswordView
    extends IView<ForgotPasswordViewParameters, ForgotPasswordViewController> {
  ForgotPasswordView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => ForgotPasswordViewController(
            ForgotPasswordViewState.initial(),
            repository: ForgotPasswordRepository(
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
                                  text: "Forgot Password?",
                                  color: "#191c1f",
                                  font: "h2",
                                ),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {
                          },
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
                                      "Don't worry! It occurs. Please enter the email address linked with your account",
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
                            inputType: InputType.email,
                            hintText: 'Enter your email',
                            key: 'email'
                          ),
                          genericCallBackList: GenericCallBackList(
                              onKeyValueChangeListener: (key, value) {
                                context.read<ForgotPasswordViewController>().updateValueMap(key, value);
                              },
                              onValidationChangeListener: (key, value) {
                                context.read<ForgotPasswordViewController>().updateValidationMap(key, value);
                              }
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BaseButtonWidget(
                                data: BaseButtonData(
                                  title: BaseTextData(
                                    text: "Send Code",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context.read<ForgotPasswordViewController>().navigateToOTPPage(context);
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
                            text: "Remember Password? ",
                            color: "#757579",
                            font: "caption",
                          ),
                        ),
                        TextImageSpanWidgetItemData(
                          type: "text-cta",
                          title: BaseTextData(
                            text: "Login ",
                            color: "#42f2f5",
                            font: "caption",
                          ),
                          button: BaseButtonData(type: ""),
                        ),
                      ],
                    ),
                    onClickListener: (cta) {
                      context.read<ForgotPasswordViewController>().onPop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
}
