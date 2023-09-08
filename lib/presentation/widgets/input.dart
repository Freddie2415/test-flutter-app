import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class Input extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String? value) validator;
  final int? maxLength;

  const Input({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.type,
    required this.validator,
    this.maxLength,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscureText = false;

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      );

  @override
  void initState() {
    super.initState();
    obscureText = widget.type == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: widget.type,
          maxLength: widget.maxLength,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: obscureText,
          obscuringCharacter: '✲',
          decoration: InputDecoration(
            prefixIcon: widget.type == TextInputType.phone
                ? Center(
                    widthFactor: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Text(
                        "+998",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : null,
            suffixIconColor: AppColor.bg,
            suffixIcon: widget.type == TextInputType.visiblePassword
                ? GestureDetector(
                    onTap: () => setState(() => obscureText = !obscureText),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColor.grey1,
                      ),
                    ),
                  )
                : null,
            hintText: widget.hint,
            contentPadding: const EdgeInsets.all(12),
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              color: AppColor.grey2,
            ),
            border: border,
            errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: AppColor.mainBlue),
            ),
            focusedErrorBorder: border,
            enabledBorder: border,
            disabledBorder: border,
            enabled: true,
            filled: true,
            fillColor: AppColor.bg,
          ),
        ),
      ],
    );
  }
}
