import 'package:app/domain/entities/category.dart';
import 'package:app/domain/usecases/get_categories_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _categoriesUseCase;

  CategoriesCubit(this._categoriesUseCase) : super(CategoriesInitial());

  void load() async {
    emit(CategoriesLoading());
    try {
      final List<Category> categories =
          await _categoriesUseCase.getCategories();

      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      print(e);
      emit(CategoriesFailure(e.toString()));
    }
  }
}
