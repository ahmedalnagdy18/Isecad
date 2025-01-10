import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? label;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle;
  final int? maxLength;
  final double? raduisSize;
  final String? counterText;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? readOnly;
  final Color? hintTextColor;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.mycontroller,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.errorStyle,
    this.maxLength,
    this.raduisSize,
    this.counterText,
    this.focusNode,
    this.autofocus,
    this.readOnly,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 22),
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      controller: mycontroller,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        counterText: counterText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 4),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        errorStyle: errorStyle,
        //  AppTexts.small.copyWith(
        //   color: AppColors.errorColor,
        //   overflow: TextOverflow.visible,
        // ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 4),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 4),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }
}
