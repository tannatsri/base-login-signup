import 'package:base_project/common/base_components/base_text_widget.dart';
import 'package:flutter/material.dart';

typedef OnClickCtaListener = void Function(BaseButtonData? cta);

class BaseButtonWidget extends StatelessWidget {
  final BaseButtonData? data;
  final OnClickCtaListener? onClickListener;

  const BaseButtonWidget({
    required this.data,
    required this.onClickListener,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          HexColor(data?.bgColor),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: HexColor(data?.borderColor),
            ),
          ),
        ),
      ),
      onPressed: () {
        onClickListener?.call(data);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BaseTextWidget(
          data: data?.title,
        ),
      ),
    );
  }
}

class BaseButtonData {
  final String? bgColor;
  final String? borderColor;
  final String? type;
  final BaseTextData? title;

  BaseButtonData({
     this.bgColor,
     this.borderColor,
     this.type,
     this.title,
  });
}
