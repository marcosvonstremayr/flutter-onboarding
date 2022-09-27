import '../../core/usecases/usecase.dart';
import '../../data/model/card_model.dart';
import '../entity/card_event.dart';
import '../repository/favorites_repository.dart';

class GetFavoriteUsecase extends Usecase<CardEvent, CardModel> {
  final FavoritesRepository _favoritesRepository;

  GetFavoriteUsecase(this._favoritesRepository);

  @override
  Future<CardEvent> call({CardModel? params}) async {
    return await _favoritesRepository.getFavoriteCard(params!);
  }
}
