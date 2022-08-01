import '../../data/model/card_model.dart';

abstract class CardRepository {
  Future<List<CardModel>> fetchCards();
}
