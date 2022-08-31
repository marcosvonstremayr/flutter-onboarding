import '../entity/card_event.dart';

abstract class CardRepository {
  Future<CardEvent> fetchFilteredCards(endpoint);
  Future<CardEvent> fetchAllCards();
}
