import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.text,
      this.contoller,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.obscureText = false,
      this.radius});
  final String? text;
  final double? radius;
  final bool obscureText;
  final Function? onChanged;
  final TextEditingController? contoller;
  final Widget? suffixIcon, prefixIcon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return TextField(
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      obscureText: obscureText,
      controller: contoller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: size.width * 0.06),
          child: suffixIcon,
        ),
        filled: true,
        fillColor: const Color(0xffeefaff),
        hintText: text ?? 'Email',
        hintStyle: GoogleFonts.poppins(color: Color(0xff948b8b), fontSize: 12),
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff62b7d5),
          ),
          borderRadius: BorderRadius.circular(radius ?? size.width * 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(radius ?? size.width * 0),
        ),
      ),
    );
  }
}
