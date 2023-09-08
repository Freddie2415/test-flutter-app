import 'package:app/presentation/blocs/auth/auth_bloc.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    BlocProvider(
      create: (context) =>
          locator.get<AuthBloc>()..add(AuthCurrentUserRequested()),
      child: const Application(),
    ),
  );
}
