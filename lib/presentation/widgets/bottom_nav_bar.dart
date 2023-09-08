import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.grey1,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              label: "Главная",
              icon: SvgPicture.asset("assets/icons/home.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/home.svg",
                colorFilter: ColorFilter.mode(
                  AppColor.mainBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Поиск",
              icon: SvgPicture.asset("assets/icons/search.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/search.svg",
                colorFilter: ColorFilter.mode(
                  AppColor.mainBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Категории",
              icon: SvgPicture.asset("assets/icons/categories.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/categories.svg",
                colorFilter: ColorFilter.mode(
                  AppColor.mainBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Профиль",
              icon: SvgPicture.asset("assets/icons/profile.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/profile.svg",
                colorFilter: ColorFilter.mode(
                  AppColor.mainBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



