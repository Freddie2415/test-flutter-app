import 'package:app/presentation/pages/authorized/profile_page/profile_page.dart';
import 'package:app/presentation/pages/guest/guest_page.dart';
import 'package:app/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/auth/auth_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return ProfilePage(user: state.user);
        }

        if (state is AuthUnauthorized) {
          return const GuestPage();
        }

        if (state is AuthError) {
          return Scaffold(
            backgroundColor: AppColor.bg,
            body: FailureWidget(
              message: state.errorMessage,
              onRetry: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(AuthCurrentUserRequested());
              },
            ),
          );
        }

        // initial, loading states
        return Scaffold(
          backgroundColor: AppColor.bg,
          body: const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, AuthState state) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }
}

class FailureWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const FailureWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Ошибка!",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message),
                ),
                const SizedBox(height: 5),
                const Divider(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Попробовать еще раз"),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
