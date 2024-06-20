import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'assets_manager.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });
Widget customFormField({
  required String valueKey,
  TextEditingController? controller,
  required String text,
  TextStyle hintStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  bool obSecureText = false,
  IconData? suffix,
  bool fill = true,
  Function? suffixPressed,
  TextInputType? type,
  FormFieldValidator<String>? validate,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      key: ValueKey(valueKey),
      cursorRadius: const Radius.circular(40),
      obscureText: obSecureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.white)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        filled: fill,
        fillColor: HexColor('#FFFFFF').withOpacity(0.2),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                  size: 28,
                ))
            : null,
        border: InputBorder.none,
        hintText: text,
        hintStyle: hintStyle,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
Widget background({required child}) => SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.background), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
