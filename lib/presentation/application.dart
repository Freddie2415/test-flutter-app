import 'package:app/presentation/root_page.dart';
import 'package:app/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app demo',
      theme: ThemeData(
        useMaterial3: false,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColor.mainBlue, width: 1.5),
            padding: const EdgeInsets.symmetric(
              vertical: 11,
              horizontal: 28,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: AppColor.mainBlue,
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 28,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColor.grey4,
          foregroundColor: Colors.black,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        )),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.2,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0.2,
          selectedItemColor: AppColor.mainBlue,
          unselectedItemColor: AppColor.greyText,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const RootPage(),
    );
  }
}
