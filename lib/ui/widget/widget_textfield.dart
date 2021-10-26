import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';

class WidgetTextField extends StatelessWidget {
  final GlobalKey<FormState>? formValidate;
  final TextEditingController? controller;
  final Color? fillColor;
  final String hintText;
  final bool? isPassWord;
  final RegExp? format;
  final IconData? suffixIcon;
  final VoidCallback? function;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  const WidgetTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.fillColor,
    this.isPassWord,
    this.format,
    this.formValidate,
    this.suffixIcon,
    this.function,
    this.focusNode,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Form(
    key: formValidate,
    child: TextFormField(
      onChanged: onChanged ?? (value) {
        if (formValidate != null) {
          formValidate!.currentState!.validate();
        }
      },

      controller: controller,
      cursorColor: AppTheme.blackColor,
      obscureText: isPassWord ?? false,
      focusNode: focusNode,
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle2,
        fillColor: fillColor ?? AppTheme.textFieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.7),
          borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.7),
          borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 0.0),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: function,
          child: Icon(suffixIcon),
        ),
      ),
    ),
  );
}