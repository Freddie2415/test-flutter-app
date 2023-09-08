import 'package:app/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectInput extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String hint;
  final bool loading;

  const SelectInput({
    super.key,
    required this.onTap,
    required this.title,
    required this.hint,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColor.bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hint,
                style: GoogleFonts.inter(fontSize: 14),
                textAlign: TextAlign.start,
              ),
              loading
                  ? const Center(
                      child: SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    )
                  : const Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );
  }
}
