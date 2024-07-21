import 'package:flutter/material.dart';

class BaseTextWidget extends StatelessWidget {
  final BaseTextData? data;

  const BaseTextWidget({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data?.text ?? "",
      style: getBaseTextStyle(data),
    );
  }
}

class BaseTextData {
  final String? text;
  final String? font;
  final String? color;

  BaseTextData({
    this.text,
    this.font,
    this.color,
  });
}

enum BaseTextFontStyle {
  heading(style: "heading", fontWeight: FontWeight.normal, fontSize: 32.0),
  h2(style: "h2", fontWeight: FontWeight.bold, fontSize: 28.0),
  caption(style: "caption", fontWeight: FontWeight.normal, fontSize: 12.0),
  body(style: "body", fontWeight: FontWeight.normal, fontSize: 16.0);

  static TextStyle textStyle(BaseTextFontStyle style, String? color) {
    return TextStyle(
      fontWeight: style.fontWeight,
      fontSize: style.fontSize,
      color: HexColor(color),
    );
  }

  const BaseTextFontStyle({
    required this.style,
    required this.fontSize,
    required this.fontWeight,
  });

  final String style;
  final FontWeight fontWeight;
  final double fontSize;
}

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    if (hexColor == null || hexColor == "") {
      return int.parse("FFFFFFFF", radix: 16);
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF${hexColor}";
    }
    try {
      return int.parse(hexColor, radix: 16);
    } catch (e) {
      return int.parse("FFFFFFFF", radix: 16);
    }
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}

TextStyle getBaseTextStyle(BaseTextData? data) {
  TextStyle textStyle = TextStyle(
    fontFamily: BaseTextFontStyle.body.style,
    fontWeight: BaseTextFontStyle.body.fontWeight,
    fontSize: BaseTextFontStyle.body.fontSize,
    color: HexColor(data?.color),
  );
  if (data != null) {
    var font = data.font;
    switch (font?.toUpperCase()) {
      case "HEADING":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.heading, data.color);
        break;
      case "BODY":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.body, data.color);
      case "CAPTION":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.caption, data.color);
        break;
      case "H2":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.h2, data.color);
        break;
    }
  }
  return textStyle;
}
