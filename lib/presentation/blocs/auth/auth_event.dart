part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthCurrentUserRequested extends AuthEvent {}
