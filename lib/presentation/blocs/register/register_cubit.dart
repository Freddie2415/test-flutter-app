import 'package:app/domain/usecases/register_use_case.dart';
import 'package:app/exceptions/exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String address,
    required String fullName,
    required String projectName,
    required int categoryId,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());
    try {
      await _registerUseCase.register(
        address: address,
        fullName: fullName,
        projectName: projectName,
        categoryId: categoryId,
        phoneNumber: phoneNumber,
      );
      emit(RegisterSuccess());
    } on ServerErrorException catch (e) {
      debugPrint(e.toString());
      if (e.statusCode == 400) {
        emit(RegisterFailure(e.message));
      }
    } catch (e) {
      print(e);
      emit(RegisterFailure(e.toString()));
    }
  }
}
