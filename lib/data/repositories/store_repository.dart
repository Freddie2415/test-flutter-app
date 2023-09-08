import 'package:app/data/datasources/remote/api/api_provider.dart';
import 'package:app/domain/entities/advertisement.dart';
import 'package:app/domain/entities/category.dart';
import 'package:app/domain/repositories/store_repository_interface.dart';

class StoreRepository extends ApiProvider implements StoreRepositoryInterface {
  StoreRepository(super.dio, super.baseUrl);

  @override
  Future<List<Category>> getCategories() async {
    final jsonList = await get("$baseUrl/store/categories-with-childs/");

    List<Category> categories =
        List.of(jsonList).map((json) => Category.fromJson(json)).toList();

    return categories;
  }

  @override
  Future<List<Advertisement>> getMyAdvertisements() async {
    final jsonList = await get("$baseUrl/store/my-ads/");

    List<Advertisement> advertisements =
        List.of(jsonList).map((json) => Advertisement.fromJson(json)).toList();

    return advertisements;
  }
}
