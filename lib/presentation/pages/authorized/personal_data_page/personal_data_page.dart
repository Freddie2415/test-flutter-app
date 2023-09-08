import 'package:app/domain/entities/user.dart';
import 'package:app/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/info_item.dart';

class PersonalDataPage extends StatelessWidget {
  final User user;

  const PersonalDataPage({
    super.key,
    required this.user,
  });

  static Route<Object?> route(User user) => MaterialPageRoute(
        builder: (context) => PersonalDataPage(
          user: user,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Персональная информация"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.grey4),
                borderRadius: BorderRadius.circular(8),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 27,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/images/avatar.png",
                        height: 54,
                        width: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.fullName,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InfoItem(
                    svgIconPath: 'assets/icons/user-phone.svg',
                    text: user.phoneNumber ?? '-',
                  ),
                  const SizedBox(height: 12),
                  InfoItem(
                    svgIconPath: 'assets/icons/user-location.svg',
                    text: user.address ?? '-',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
