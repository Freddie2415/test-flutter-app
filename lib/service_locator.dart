import 'package:app/data/datasources/interfaces/token_datasource.dart';
import 'package:app/data/datasources/local/refresh_token_storage.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/repositories/store_repository.dart';
import 'package:app/domain/repositories/auth_repository_interface.dart';
import 'package:app/domain/repositories/store_repository_interface.dart';
import 'package:app/domain/usecases/get_categories_use_case.dart';
import 'package:app/domain/usecases/get_current_user_use_case.dart';
import 'package:app/domain/usecases/login_use_case.dart';
import 'package:app/domain/usecases/logout_use_case.dart';
import 'package:app/domain/usecases/register_use_case.dart';
import 'package:app/presentation/blocs/auth/auth_bloc.dart';
import 'package:app/presentation/blocs/categories/categories_cubit.dart';
import 'package:app/presentation/blocs/login/login_cubit.dart';
import 'package:app/presentation/blocs/register/register_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/interceptors/token_interceptor.dart';
import 'data/datasources/local/access_token_storage.dart';

final locator = GetIt.instance;
const apiBaseUrl = 'https://backendmaster.pythonanywhere.com/en/api/v1';

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.reload();
  final dio = Dio();

  locator.registerSingleton(sharedPreferences);
  locator.registerLazySingleton<Dio>(() => dio);

  if (kDebugMode) {
    locator.get<Dio>().interceptors.add(PrettyDioLogger());
  }

  locator.get<Dio>().interceptors.add(
        TokenInterceptor(
          accessTokenStorage: AccessTokenStorage(sharedPreferences),
          refreshTokenStorage: RefreshTokenStorage(sharedPreferences),
          dio: dio,
        ),
      );

  /// data sources
  locator.registerSingleton<TokenDataSource>(
    AccessTokenStorage(sharedPreferences),
  );

  /// repositories
  locator.registerFactory<AuthRepositoryInterface>(
    () => AuthRepository(
      locator.get<Dio>(),
      apiBaseUrl,
      locator.get<TokenDataSource>(),
    ),
  );
  locator.registerFactory<StoreRepositoryInterface>(
    () => StoreRepository(dio, apiBaseUrl),
  );

  /// use cases
  locator.registerFactory<LoginUseCase>(
    () => LoginUseCase(
      locator.get<AuthRepositoryInterface>(),
      AccessTokenStorage(sharedPreferences),
      RefreshTokenStorage(sharedPreferences),
    ),
  );
  locator.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(
      locator.get<AuthRepositoryInterface>(),
    ),
  );
  locator.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      locator.get<AuthRepositoryInterface>(),
    ),
  );
  locator.registerFactory<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(
      locator.get<StoreRepositoryInterface>(),
    ),
  );
  locator.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(
      locator.get<AuthRepositoryInterface>(),
    ),
  );

  /// state manages blocs, cubits
  locator.registerSingleton<AuthBloc>(
    AuthBloc(
      locator.get<LogoutUseCase>(),
      locator.get<GetCurrentUserUseCase>(),
    ),
  );
  locator.registerFactory<LoginCubit>(
    () => LoginCubit(
      locator.get<LoginUseCase>(),
      locator.get<AuthBloc>(),
    ),
  );
  locator.registerFactory<RegisterCubit>(
    () => RegisterCubit(locator.get<RegisterUseCase>()),
  );
  locator.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(locator.get<GetCategoriesUseCase>()),
  );
}
