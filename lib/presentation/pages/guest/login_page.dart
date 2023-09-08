import 'package:app/presentation/blocs/login/login_cubit.dart';
import 'package:app/presentation/pages/guest/register_page.dart';
import 'package:app/presentation/theme.dart';
import 'package:app/presentation/widgets/header_text.dart';
import 'package:app/service_locator.dart';
import 'package:app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/input.dart';
import '../../widgets/text_divider.dart';
import 'success_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static Route<Object?> route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<LoginCubit>(
        create: (context) => locator.get<LoginCubit>(),
        child: const LoginPage(),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Войти"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - kToolbarHeight - 30,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  onChanged: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HeaderText(
                        title: 'Добро пожаловать!',
                        subtitle: 'Войти в систему чтобы торговать в системе',
                      ),
                      const SizedBox(height: 24),
                      Input(
                        title: 'Логин',
                        hint: 'Введите логин',
                        controller: _loginController,
                        type: TextInputType.text,
                        validator: Validator.required,
                      ),
                      const SizedBox(height: 16),
                      Input(
                        title: 'Пароль',
                        hint: 'Введите пароль',
                        controller: _passwordController,
                        type: TextInputType.visiblePassword,
                        validator: Validator.required,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: false,
                            isScrollControlled: true,
                            useSafeArea: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                builder: (
                                  BuildContext context,
                                  ScrollController scrollController,
                                ) {
                                  return SafeArea(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/info.svg",
                                              ),
                                              Text(
                                                "Забыли пароль? Для восстановления пароля обратитесь администратору",
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: AppColor.grey1,
                                                  height: 1.4,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const Spacer(),
                                              ElevatedButton(
                                                style: ButtonStyles.primary(),
                                                onPressed: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/phone.svg"),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                      "+998 97 450 45 00",
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          "Забыли пароль?",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColor.mainBlue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Spacer(),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: state is LoginLoading
                                ? null
                                : () {
                                    var validated =
                                        _formKey.currentState?.validate();
                                    if (validated == true) {
                                      BlocProvider.of<LoginCubit>(context)
                                          .login(
                                        login: _loginController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
                            child: const Text("Войти"),
                          );
                        },
                      ),
                      const TextDivider(text: "Хотите стать продавцом?"),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            RegisterPage.route(),
                          );
                        },
                        child: const Text("Подать заявку"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
