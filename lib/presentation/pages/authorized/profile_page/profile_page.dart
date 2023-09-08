import 'package:app/domain/entities/user.dart';
import 'package:app/presentation/blocs/auth/auth_bloc.dart';
import 'package:app/presentation/pages/authorized/my_ads_page/my_ads_page.dart';
import 'package:app/presentation/theme.dart';
import 'package:app/presentation/widgets/bottom_sheet_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../personal_data_page/personal_data_page.dart';
import 'widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            BottomSheetSelect.showSelectBottomSheet(
              context: context,
              initialChildSize: 0.5,
              title: 'Выберите язык',
              items: ['English', 'O’zbekcha', 'Русский'],
              selectedItem: 'Русский',
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/ru.svg"),
              const SizedBox(width: 10),
              Text(
                "РУ",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined)
            ],
          ),
        ),
        title: SvgPicture.asset("assets/images/logo.svg"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
            },
            icon: SvgPicture.asset("assets/icons/logout.svg"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, PersonalDataPage.route(user));
              },
              child: Container(
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
                        child: user.profilePhoto != null
                            ? Image.network(
                                user.profilePhoto!,
                                height: 54,
                                width: 54,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.account_circle,
                                size: 54,
                                color: AppColor.mainBlue,
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuItem(
              title: "Персональные данные",
              svgIconPath: 'assets/icons/user-profile.svg',
              onTap: () {
                Navigator.push(context, PersonalDataPage.route(user));
              },
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "Мои объявления",
              svgIconPath: 'assets/icons/grid.svg',
              onTap: () {
                Navigator.push(context, MyAdsPage.route());
              },
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "Настройки",
              svgIconPath: 'assets/icons/settings.svg',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "Уведомления",
              onTap: () {},
              trailing: SizedBox(
                height: 24,
                child: CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "Язык",
              onTap: () {
                BottomSheetSelect.showSelectBottomSheet(
                  context: context,
                  initialChildSize: 0.5,
                  title: 'Выберите язык',
                  items: ['English', 'O’zbekcha', 'Русский'],
                  selectedItem: 'Русский',
                );
              },
              trailing: Row(
                children: [
                  Text(
                    "Русский",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    "assets/icons/ru.svg",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "Правила пользования",
              svgIconPath: 'assets/icons/policy.svg',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            ProfileMenuItem(
              title: "О нас",
              svgIconPath: 'assets/icons/about.svg',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
