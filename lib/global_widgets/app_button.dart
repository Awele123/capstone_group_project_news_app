import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {super.key,
      this.buttonColor,
      this.text,
      this.onTap,
      this.height,
      this.textColor,
      this.width});
  final Color? buttonColor, textColor;
  final String? text;
  final Function? onTap;
  final double? height, width;
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        height: widget.height ?? size.height * 0.07,
        width: widget.width,
        decoration:
            BoxDecoration(color: widget.buttonColor ?? Color(0xff62b7d5)),
        child: Center(
          child: Text(
            widget.text ?? 'Sign In',
            style: TextStyle(
                color: widget.textColor ?? Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
