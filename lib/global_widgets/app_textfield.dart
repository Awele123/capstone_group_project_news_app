import 'package:capstone_news_app/constants/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    this.readOnly = false,
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
    this.fillColor,
    this.initValue,
    this.initStyle,
    this.verticalWidth,
  });

  final bool readOnly;
  final String? text, errorText, initValue;
  final double? radius, verticalWidth;
  final Color? fillColor;
  final bool obscureText;
  final Function? onChanged;
  final TextEditingController? controller;
  final TextStyle? initStyle;
  final Widget? suffixIcon, prefixIcon;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _internalFocusNode;
  late bool _isFocused;
  TextEditingController? _internalController;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;
  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _isFocused = false;

    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initValue ?? '');
    } else if (widget.initValue != null) {
      widget.controller!.text = widget.initValue!;
    }

    _effectiveFocusNode.addListener(() {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _internalFocusNode.dispose();
    if (widget.controller == null) _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return TextFormField(
      readOnly: widget.readOnly,
      style: widget.initStyle,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
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
        fillColor: widget.fillColor ?? const Color(0xffeefaff),
        hintText: widget.text ?? 'Enter value',
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xff948b8b),
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: widget.verticalWidth ?? size.width * 0.03,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff62b7d5)),
          borderRadius: BorderRadius.circular(widget.radius ?? size.width * 0.02),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(widget.radius ?? size.width * 0.02),
        ),
      ),
    );
  }
}
