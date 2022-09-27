import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasource/local/DAOs/database.dart';
import '../../data/model/card_model.dart';
import '../entity/card_event.dart';

mixin ParseDatabaseResponse {
  Database get database;

  Future<CardEvent> parseDatabaseResponse({
    required String document,
    required String specificEndpoint,
  }) async {
    List<CardModel> cardsModels = [];
    try {
      QuerySnapshot dbResponse = await database.readCards(
        mainCollectionDocument: document,
        subcollection: specificEndpoint,
      );
      if (dbResponse.docs.isEmpty) {
        return CardEvent(status: Status.empty);
      } else {
        List<QueryDocumentSnapshot> cards = dbResponse.docs;
        cards.forEach((card) {
          var cardElement = CardModel.fromJson(card.data());
          if (cardElement.cardId != null) {
            cardsModels.add(cardElement);
          }
        });
        return CardEvent(
          cards: cardsModels,
          status: Status.success,
        );
      }
    } catch (e) {
      return CardEvent(
        status: Status.error,
        errorMsg: "$e",
      );
    }
  }
}
