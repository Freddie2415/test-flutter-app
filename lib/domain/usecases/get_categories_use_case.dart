import '../entities/category.dart';
import '../repositories/store_repository_interface.dart';

class GetCategoriesUseCase {
  final StoreRepositoryInterface _storeRepository;

  GetCategoriesUseCase(this._storeRepository);

  Future<List<Category>> getCategories() {
    return _storeRepository.getCategories();
  }
}
