import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/text_divider.dart';
import 'login_page.dart';
import 'register_page.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/profile.svg"),
            const SizedBox(height: 10),
            Text(
              "Продавайте на нашей платформе",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF16191D),
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Если вы хотите сотрудник или хотите сотрудничать с нами войдите или оставьте заявку",
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E9297),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, LoginPage.route());
              },
              child: const Text("Войти"),
            ),
            const TextDivider(text: "или"),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, RegisterPage.route());
              },
              child: const Text("Подать заявку"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}
