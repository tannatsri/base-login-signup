import 'package:base_project/common/base_components/base_button_widget.dart';
import 'package:base_project/common/base_components/base_image_widget.dart';
import 'package:base_project/common/base_components/base_scaffold.dart';
import 'package:base_project/common/base_components/base_text_widget.dart';
import 'package:base_project/common/base_components/text_image_span_widget.dart';
import 'package:base_project/core/views/core/view/view.dart';
import 'package:base_project/pages/splash_page/repository/splash_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/providers/network_provider.dart';
import '../../core/providers/router/core/registry.dart';
import '../../core/providers/router/core/router.dart';
import 'controller/splash_view_controller.dart';
import 'controller/splash_view_states.dart';

class SplashViewParameters extends IViewParameters {
  SplashViewParameters();

  SplashViewParameters.from(LinkParameters parameters) : super.from(parameters);

  @override
  Map<String, dynamic> toJson() => {};
}

class SplashView extends IView<SplashViewParameters, SplashViewController> {
  SplashView({
    super.key,
    required super.parameters,
  }) : super(
          creator: (context) => SplashViewController(
            SplashViewState.initial(),
            repository: SplashRepository(
              networkAssistant: context.read<INetworkAssistant>(),
            ),
            router: readFrom(context),
          ),
          builder: (context) => BaseScaffold(
            child: Column(
              children: [
                BaseImageWidget(
                  data: BaseImageData(
                    png:
                        "https://indcdn.indmoney.com/cdn/images/fe/temp-test-layout-rendering.png",
                    aspectRatio: 0.93,
                  ),
                ),
                const   SizedBox(height: 10,),
                BaseImageWidget(
                  data: BaseImageData(
                    png:
                    "https://indcdn.indmoney.com/cdn/images/fe/temp-image-parsing-testing.png",
                    height: 110,
                    width: 150,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                  context.read<SplashViewController>().onLoginTap();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BaseButtonWidget(
                                data: BaseButtonData(
                                  title: BaseTextData(
                                    text: "Register",
                                    color: "#191c1f",
                                    font: "body",
                                  ),
                                  bgColor: "#ffffff",
                                  borderColor: "#191c1f",
                                ),
                                onClickListener: (cta) {
                                  context.read<SplashViewController>().onSignUpTap();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        TextImageSpanWidget(
                          data: TextImageSpanWidgetData(
                            list: [
                              TextImageSpanWidgetItemData(
                                type: "text-cta",
                                title: BaseTextData(
                                  text: "Continue as guest",
                                  color: "#42f2f5",
                                  font: "body"
                                ),
                                button: BaseButtonData(
                                  type: "",
                                ),
                              ),
                            ]
                          ),
                          onClickListener: (cta) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
