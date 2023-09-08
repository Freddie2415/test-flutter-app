import '../entities/advertisement.dart';
import '../repositories/store_repository_interface.dart';

class GetMyAdvertisementsUseCase {
  final StoreRepositoryInterface _storeRepository;

  GetMyAdvertisementsUseCase(this._storeRepository);

  Future<List<Advertisement>> call() {
    return _storeRepository.getMyAdvertisements();
  }
}
