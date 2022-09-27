import '../../core/usecases/usecase.dart';
import '../../data/model/card_model.dart';
import '../entity/card_event.dart';
import '../repository/favorites_repository.dart';

class GetFavoritesUsecase extends Usecase<CardEvent, CardModel> {
  final FavoritesRepository _favoritesRepository;

  GetFavoritesUsecase(this._favoritesRepository);

  @override
  Future<CardEvent> call({CardModel? params}) async {
    return await _favoritesRepository.fetchFavoriteCards();
  }
}
