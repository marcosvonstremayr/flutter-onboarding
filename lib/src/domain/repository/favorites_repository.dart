import '../../data/model/card_model.dart';
import '../entity/card_event.dart';

abstract class FavoritesRepository {
  Future<CardEvent> saveFavoriteCard(CardModel card);
  Future<CardEvent> getFavoriteCard(CardModel card);
  Future<CardEvent> fetchFavoriteCards();
}
