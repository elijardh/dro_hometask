import 'package:flutter/material.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final int maxLines;
  final FontWeight fontWeight;

  const TitleText(
      {this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: Theme.of(context).textTheme.headline1.copyWith(
          fontSize: fontSize != null
              ? SizeConfig().sp(fontSize).toDouble()
              : SizeConfig().sp(25).toDouble(),
          color: textColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.bold),
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final int maxLines;
  final TextDecoration decoration;

  const NormalText(
      {this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.fontWeight,
      this.maxLines,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
          decoration: decoration,
          fontSize: fontSize != null
              ? SizeConfig().sp(fontSize, allowFontScalingSelf: true).toDouble()
              : SizeConfig().sp(15).toDouble(),
          color: textColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final int maxLines;

  const SubtitleText(
      {this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: Theme.of(context).textTheme.headline2.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: fontSize != null
              ? SizeConfig().sp(fontSize).toDouble()
              : SizeConfig().sp(20).toDouble(),
          color: textColor ?? Colors.black),
    );
  }
}

class AccentText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final int maxLines;

  const AccentText(
      {this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: fontSize != null
              ? SizeConfig().sp(fontSize).toDouble()
              : SizeConfig().sp(15).toDouble(),
          color: textColor ?? Colors.black),
    );
  }
}
