import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zoftcares/constants/app_constants.dart';

class AuthTextFiled extends HookWidget {
  const AuthTextFiled(
      {super.key,
      required this.controller,
      required this.inputType,
      this.hintText,
      this.isPassword = false,
      this.prefix,
      this.prefixIcon,
      this.textStyle,
      this.enabled = true,
      this.borderColor,
      this.validator,
      this.errorColor,
      this.contentPadding});
  final String? hintText;
  final bool isPassword;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final TextInputType inputType;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final Color? borderColor;
  final EdgeInsets? contentPadding;
  final Color? errorColor;

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(isPassword);
    return TextFormField(
      onTapOutside: (event) => AppConstants.dismissKeyboard(),
      style: textStyle,
      enabled: enabled,
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      obscureText: showPassword.value,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black)),
          prefix: prefix,
          prefixIcon: prefixIcon,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          contentPadding: contentPadding ??
              const EdgeInsets.only(left: 20, top: 12, bottom: 12),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          filled: false,
          hintText: hintText,
          labelText: hintText,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    showPassword.value
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                  onPressed: () {
                    showPassword.value = !showPassword.value;
                  },
                )
              : null),
    );
  }
}
