import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.labelText,
    this.iconData,
    this.onIconPressed,
    this.isPassword = false,
  });

  final String hintText, labelText;
  final Widget? iconData;
  final VoidCallback? onIconPressed;
  final bool isPassword;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: widget.iconData != null
            ? IconButton(
                icon: widget.iconData!,
                onPressed: widget.onIconPressed,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(_isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off))
            : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      scrollPadding: const EdgeInsets.only(bottom: 20.0),
      cursorColor: Colors.green,
    );
  }
}
