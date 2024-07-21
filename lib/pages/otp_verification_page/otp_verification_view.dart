import 'package:base_project/common/base_components/base_input_widget.dart';
import 'package:base_project/pages/otp_verification_page/repository/otp_verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/base_components/base_app_bar.dart';
import '../../common/base_components/base_button_widget.dart';
import '../../common/base_components/base_scaffold.dart';
import '../../common/base_components/base_text_widget.dart';
import '../../common/base_components/text_image_span_widget.dart';
import '../../core/providers/router/core/router.dart';
import '../../core/views/core/view/view.dart';
import 'controller/otp_verification_view_controller.dart';
import 'controller/otp_verification_view_states.dart';

class OtpVerificationViewParameters extends IViewParameters {
  OtpVerificationViewParameters();

  OtpVerificationViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class OtpVerificationView extends IView<OtpVerificationViewParameters,
    OtpVerificationViewController> {
  OtpVerificationView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => OtpVerificationViewController(
            OtpVerificationViewState.initial(),
            repository: OtpVerificationRepository(
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
                                  text: "OTP Verification",
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
                                      "Enter the verification code we just sent on your email address.",
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
                        OTPInputWidget(
                          genericCallBackList: GenericCallBackList(
                            onValidationChangeListener: (key, validation) {
                              context
                                  .read<OtpVerificationViewController>().updateValidationMap(key, validation);
                            },
                            onKeyValueChangeListener: (key, value) {
                              context
                                  .read<OtpVerificationViewController>().updateValueMap(key, value);
                            },
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
                                    text: "Verify",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context
                                      .read<OtpVerificationViewController>()
                                      .onOTPTapPage(context);
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
                          button: BaseButtonData(type: ""),
                        ),
                      ],
                    ),
                    onClickListener: (cta) {
                      context
                          .read<OtpVerificationViewController>()
                          .openRegistrationPage();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
}

class OTPInputWidget extends StatefulWidget {
  final GenericCallBackList? genericCallBackList;

  const OTPInputWidget({
    super.key,
    this.genericCallBackList,
  });

  @override
  _OTPInputWidgetState createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  final List<FocusNode> _focusNodes =
      List<FocusNode>.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List<TextEditingController>.generate(
          4, (index) => TextEditingController());

  @override
  void initState() {
    widget.genericCallBackList?.onKeyValueChangeListener?.call('otp', "");
    widget.genericCallBackList?.onValidationChangeListener?.call('otp', false);
    super.initState();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    bool isValid =
        _controllers.every((controller) => controller.text.length == 1);
    String otpValue = _controllers.map((controller) => controller.text).join();

    widget.genericCallBackList?.onKeyValueChangeListener?.call('otp', otpValue);
    widget.genericCallBackList?.onValidationChangeListener
        ?.call('otp', isValid);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: (_controllers[index].text.length != 1)
                  ? Colors.black
                  : HexColor("#42f2f5"),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        );
      }),
    );
  }
}
