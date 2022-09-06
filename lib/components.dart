import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required String label,
  MaterialColor labelColor = Colors.blue,
  required IconData prefix,
  MaterialColor prefixIconColor = Colors.blue,
  IconData? suffix,
  double radius = 0.0,
  required TextInputType textInputType,
  required var controller,
  Function()? onSubmitted,
  var onChange,
  Function()? onTap,
  required validate,
  var onSuffixPressed,
  bool isPassword = false,
  MaterialColor borderColor = Colors.blue,
  MaterialColor textColor = Colors.blue,
}) =>
    TextFormField(
      style: TextStyle(color: textColor),
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      onFieldSubmitted: (value) {
        onSubmitted!();
      },
      onChanged: onChange,
      onTap: onTap,
      keyboardType: textInputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        prefixIcon: Icon(
          prefix,
          color: prefixIconColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: onSuffixPressed,
              )
            : null,
      ),
    );

Widget spaceInHeight({required double height}) => SizedBox(height: height);
Widget spaceInWidth({required double width}) => SizedBox(width: width);
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
