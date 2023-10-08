import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      style: AppStyles.black000Size14Fw400FfMont,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: ColorConstants.darkGray.withOpacity(.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.grey.shade100,
        labelText: widget.hintText,
        labelStyle: const TextStyle(
          color: ColorConstants.accent1,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
      ),
      cursorColor: ColorConstants.primaryButton,
    );
  }
}
