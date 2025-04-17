import 'package:flutter/material.dart';

class DefaultTextbox extends StatelessWidget {
  const DefaultTextbox(
      {super.key,
      this.textStyle,
        this.inputBorder= const OutlineInputBorder(), //the border when you want to write,
      this.hintText,
      this.label,
      this.prefixIcon,
      this.enableBorder, //border before you want to write
      this.suffixIcon,
      this.controller,
      this.textInputType,
      this.onChanged,
      this.onTap,
      this.onFieldSubmitted,
      this.validator,
      this.textInputAction,
      this.focusNode,
      this.direction,
      this.textKey,
      this.obscureText=false,
      this.autocorrect=true});

  final TextStyle? textStyle;
  final InputBorder inputBorder;
  final String? hintText;
  final String? label;
  final Widget? prefixIcon;
  final InputBorder? enableBorder;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool obscureText ;
  final bool autocorrect ;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextDirection? direction;
  final Key? textKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textKey,
      textInputAction: textInputAction,
      textDirection: direction,
      focusNode: focusNode,
      autofocus: true,
      style: textStyle,
      decoration: InputDecoration(
        border: inputBorder,
        hintText: hintText,
        prefixIcon: prefixIcon,
        enabledBorder: enableBorder,
        suffixIcon: suffixIcon,
        labelText: label,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: suffixIcon != null ? 16.0 : 12.0),
      ),
      controller: controller,
      keyboardType: textInputType,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      autocorrect: autocorrect,
      validator: validator,
    );
  }
}
