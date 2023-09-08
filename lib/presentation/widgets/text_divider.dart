import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              indent: 0,
              endIndent: 0,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColor.grey1,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(
              indent: 0,
              endIndent: 0,
            ),
          ),
        ],
      ),
    );
  }
}
