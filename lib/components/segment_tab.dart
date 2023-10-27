import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';



class SegmentTab extends StatefulWidget {
  final ThemeIcon? icon;
  final String? image;

  final String title;

  final bool isSelected;
  final double? cornerRadius;

  final Color? inActiveBgColor;
  final Color? activeBgColor;

  final Color? inActiveIconColor;
  final Color? activeIconColor;

  final TextStyle? inActiveTextStyle;
  final TextStyle? activeTextStyle;

  final Color? borderColor;

  const SegmentTab({
    Key? key,
    this.icon,
    this.image,
    required this.title,
    required this.isSelected,
    this.inActiveBgColor,
    this.cornerRadius,
    this.activeBgColor,
    this.inActiveIconColor,
    this.activeIconColor,
    this.inActiveTextStyle,
    this.activeTextStyle,
    this.borderColor,
  }) : super(key: key);

  @override
  SegmentTabState createState() => SegmentTabState();
}

class SegmentTabState extends State<SegmentTab> {
  ThemeIcon? icon;
  String? image;

  late String title;
  late double cornerRadius;

  @override
  void initState() {
    // TODO: implement initState
    icon = widget.icon;
    image = widget.image;
    title = widget.title;
    cornerRadius = widget.cornerRadius ?? 5;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return segmentType1();
  }

  Widget segmentType1() {
    return Container(
      child: icon != null
          ? Row(
        children: [
          icon != null
              ? ThemeIconWidget(
            icon!,
            color: widget.isSelected == true
                ? widget.activeIconColor ??
                Theme.of(context).backgroundColor
                : widget.inActiveIconColor ?? Theme.of(context).primaryColor,
            size: 15,
          )
              : Container(
            width: 1,
          ),
          Text(title,
              style: widget.isSelected == true
                  ? widget.activeTextStyle ??
                  Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                  : widget.inActiveTextStyle ??
                  Theme
                      .of(context)
                      .textTheme
                      .bodySmall)
              .hP8
        ],
      ).hP8
          : Center(
          child: Text(title,
              style: widget.isSelected == true
                  ? widget.activeTextStyle ??
                  Theme
                      .of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600)
                  : widget.inActiveTextStyle ?? Theme
                  .of(context)
                  .textTheme
                  .bodySmall!)
              .hP16),
    )
        .shadow(
        context: context,
        radius: cornerRadius,
        fillColor: widget.isSelected == true
            ? widget.activeBgColor ?? Theme.of(context).primaryColor
            : widget.inActiveBgColor)
        .vP4;
  }

  Widget segmentType2() {
    return Container(
      child: icon != null
          ? Row(
        children: [
          icon != null
              ? ThemeIconWidget(
            icon!,
            color: widget.isSelected == true
                ? widget.activeIconColor ??
                Theme.of(context).backgroundColor
                : widget.inActiveIconColor ?? Theme.of(context).primaryColor,
            size: 15,
          )
              : Container(
            width: 1,
          ),
          Text(title,
              style: widget.isSelected == true
                  ? widget.activeTextStyle ?? Theme
                  .of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Theme
                  .of(context)
                  .primaryColor)
                  : widget.inActiveTextStyle ?? Theme
                  .of(context)
                  .textTheme
                  .displaySmall!)
              .hP8
        ],
      ).hP8
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: widget.isSelected == true
                  ? widget.activeTextStyle ?? Theme
                  .of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Theme
                  .of(context)
                  .primaryColor)
                  : widget.inActiveTextStyle ?? Theme
                  .of(context)
                  .textTheme
                  .displaySmall!)
              .bp(12),
          Container(
            height: 5,
            color: widget.isSelected == true
                ? widget.activeBgColor ?? Theme.of(context).primaryColor
                : widget.inActiveBgColor,
            width: 50,
          ).round(5)
        ],
      ),
    );
  }

  Widget segmentType3() {
    return Container(
        child: Column(
          children: [
            Container(
              height: 45,
              width: 50,
              color: widget.isSelected == true
                  ? widget.activeBgColor ?? Theme.of(context).primaryColor
                  : widget.inActiveBgColor ?? Theme.of(context).backgroundColor.withOpacity(0.1),
              child: Image
                  .asset(
                image!,
                color: Theme.of(context).backgroundColor,
              )
                  .p8,
            )
                .round(18)
                .bP16,
            Text(title,
                style: widget.isSelected == true
                    ? widget.activeTextStyle ??
                    Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w600)
                    : widget.inActiveTextStyle ??
                    Theme
                        .of(context)
                        .textTheme
                        .bodySmall
            )
          ],
        ).hP8);
  }
}

