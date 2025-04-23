import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart'; // Update path as needed

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    this.buttonColor,
    this.text,
    this.onTap,
    this.height,
    this.textColor,
    this.width,
  });

  final Color? buttonColor, textColor;
  final String? text;
  final Function()? onTap;
  final double? height, width;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<AuthCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return GestureDetector(
          onTap: isLoading ? null : widget.onTap,
          child: Container(
            height: widget.height ?? size.height * 0.055,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.buttonColor ?? const Color(0xff62b7d5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.text ?? 'Sign In',
                      style: TextStyle(
                        color: widget.textColor ?? Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
