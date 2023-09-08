import 'package:app/domain/entities/advertisement.dart';
import 'package:app/domain/entities/category.dart';

abstract interface class StoreRepositoryInterface {
  Future<List<Category>> getCategories();

  Future<List<Advertisement>> getMyAdvertisements();
}
