import '../../core/usecases/usecase.dart';
import '../../data/model/card_model.dart';
import '../entity/card_event.dart';
import '../repository/favorites_repository.dart';

class SaveFavoritesUsecase extends Usecase<CardEvent, CardModel> {
  final FavoritesRepository _favoritesRepository;

  SaveFavoritesUsecase(this._favoritesRepository);

  @override
  Future<CardEvent> call({CardModel? params}) async {
    return await _favoritesRepository.saveFavoriteCard(params!);
  }
}
