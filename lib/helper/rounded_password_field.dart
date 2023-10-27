import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? label;
  final bool? showDivider;
  final bool? iconOnRightSide;
  final ThemeIcon? icon;
  final Color? iconColor;
  final bool? showRevealPasswordIcon;
  final bool? showLabelInNewLine;
  final bool? showBorder;
  final Color? borderColor;
  final bool? isError;
  final bool? startedEditing;
  final double? cornerRadius;

  final Color? cursorColor;
  final TextStyle? textStyle;

  const PasswordField({
    Key? key,
    this.onChanged,
    this.controller,
    this.label,
    this.hintText,
    this.showDivider = false,
    this.backgroundColor,
    this.iconOnRightSide,
    this.iconColor,
    this.icon,
    this.showLabelInNewLine = true,
    this.showRevealPasswordIcon = false,
    this.showBorder = false,
    this.borderColor,
    this.isError = false,
    this.startedEditing = false,
    this.cornerRadius = 0,
    this.cursorColor,
    this.textStyle,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  late String? label;
  late String? hintText;
  late bool? showDivider;
  late Color? backgroundColor;
  late bool? iconOnRightSide;
  late ThemeIcon? icon;
  late Color? iconColor;
  late bool? showRevealPasswordIcon;
  late bool? showLabelInNewLine;
  late bool? showBorder;
  late Color? borderColor;
  late bool? isError;
  late bool? startedEditing;
  late double? cornerRadius;
  late ValueChanged<String>? onChanged;
  late TextEditingController? controller;

  late Color? cursorColor;
  late TextStyle? textStyle;

  @override
  void initState() {
    // TODO: implement initState
    onChanged = widget.onChanged;
    controller = widget.controller;
    hintText = widget.hintText;
    label = widget.label;
    showDivider = widget.showDivider;
    backgroundColor = widget.backgroundColor;
    iconColor = widget.iconColor;
    icon = widget.icon;
    iconOnRightSide = widget.iconOnRightSide;
    showRevealPasswordIcon = widget.showRevealPasswordIcon;
    showLabelInNewLine = widget.showLabelInNewLine;
    showBorder = widget.showBorder;
    borderColor = widget.borderColor;
    isError = widget.isError;
    startedEditing = widget.startedEditing;
    cornerRadius = widget.cornerRadius;

    cursorColor = widget.cursorColor;
    textStyle = widget.textStyle;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isError == false
            ? backgroundColor
            : (showDivider == false && showBorder == false)
            ? Theme.of(context).errorColor
            : backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        border: showBorder == true
            ? Border.all(
            width: 0.5,
            color: isError == true
                ? Theme.of(context).errorColor
                : borderColor ?? Theme.of(context).primaryColorLight)
            : null,
      ),
      height: label != null ? 70 : 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (label != null && showLabelInNewLine == true)
              ? Text(label!,
              style: Theme.of(context).textTheme.subtitle1)
              .bP4
              : Container(),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 20),
                (label != null && showLabelInNewLine == false)
                    ? Text(label!,

                    style: Theme.of(context).textTheme.bodySmall)
                    .bP4
                    : Container(),
                iconView(),
                Expanded(
                  child: Focus(
                    child: TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: controller,
                        onChanged: onChanged,
                        // cursorColor: cursorColor ?? AppTheme().black,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          hintStyle: Theme.of(context).textTheme.titleSmall,
                          hintText: hintText,
                          border: InputBorder.none,
                        ))
                        ,
                    onFocusChange: (hasFocus) {
                      startedEditing = hasFocus;
                      setState(() {});
                    },
                  ),
                ),
                revealPasswordIcon()
              ],
            ),
          ),
          line()
        ],
      ),
    );
  }

  Widget revealPasswordIcon() {
    return showRevealPasswordIcon == true
        ? ThemeIconWidget(
      showPassword == false ? ThemeIcon.reveal : ThemeIcon.hide,
      color: Theme.of(context).iconTheme.color,
      size: 20,
    ).rP16.ripple(() {
      setState(() {
        showPassword = !showPassword;
      });
    })
        : Container();
  }

  Widget line() {
    return showDivider == true
        ? Container(
        height: 0.5,
        color: startedEditing == true
            ? Theme.of(context).iconTheme.color
            : isError == true
            ? Theme.of(context).errorColor
            : Theme.of(context).dividerColor)
        : Container();
  }

  Widget iconView() {
    return icon != null
        ? ThemeIconWidget(
      icon!,
      color: iconColor ?? Theme.of(context).primaryColor,
      size: 20,
    ).rP16
        : Container();
  }
}
