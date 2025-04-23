import 'package:capstone_news_app/constants/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.text,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.obscureText = false,
    this.radius,
    this.errorText,
    this.focusNode,
  });

  final String? text, errorText;
  final double? radius;
  final bool obscureText;
  final Function? onChanged;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _effectiveFocusNode.addListener(() {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose(); // only dispose if we created it
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return TextField(
      focusNode: _effectiveFocusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      onTapOutside: (_) => dismissKeyboard(context),
      onChanged: (value) => widget.onChanged?.call(value),
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 10,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: size.width * 0.06),
          child: widget.suffixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: _isFocused
                        ? const Color(0xff62b7d5)
                        : const Color.fromARGB(255, 185, 178, 178),
                  ),
                  child: widget.suffixIcon!,
                )
              : null,
        ),
        filled: true,
        fillColor: const Color(0xffeefaff),
        hintText: widget.text ?? 'Email',
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xff948b8b),
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff62b7d5)),
          borderRadius: BorderRadius.circular(widget.radius ?? size.width * 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(widget.radius ?? size.width * 0),
        ),
      ),
    );
  }
}
