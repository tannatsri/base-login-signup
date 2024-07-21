import 'package:base_project/common/base_components/base_image_widget.dart';
import 'package:base_project/pages/password_change_status_page/repository/password_change_repository.dart';
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
import 'controller/password_change_view_controller.dart';
import 'controller/password_change_view_states.dart';

class PasswordChangeViewParameters extends IViewParameters {
  PasswordChangeViewParameters();

  PasswordChangeViewParameters.from(super.parameters) : super.from();

  @override
  Map<String, dynamic> toJson() => {};
}

class PasswordChangeView
    extends IView<PasswordChangeViewParameters, PasswordChangeViewController> {
  PasswordChangeView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => PasswordChangeViewController(
            PasswordChangeViewState.initial(),
            repository: PasswordChangeRepository(
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
                            alignment: "center",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "image",
                                logo: BaseImageData(
                                  png: "https://indcdn.indmoney.com/cdn/images/fe/error_icon_ind_garage.png",
                                  height: 44,
                                  width: 44,
                                ),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {},
                        ),const SizedBox(
                          height: 28,
                        ),
                        TextImageSpanWidget(
                          data: TextImageSpanWidgetData(
                            alignment: "center",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text: "Password Changed",
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
                            alignment: "center",
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text:
                                  "Your password has been changed successfully",
                                  color: "#757779",
                                  font: "caption",
                                ),
                              ),
                            ],
                          ),
                          onClickListener: (cta) {},
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
                                    text: "Back to Login",
                                    color: "#ffffff",
                                    font: "body",
                                  ),
                                  bgColor: "#191c1f",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context.read<PasswordChangeViewController>().navigateToLoginScreen();
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
