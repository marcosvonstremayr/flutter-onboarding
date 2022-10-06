import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/util/string_constants.dart';
import '../../domain/entity/card_event.dart';
import '../../domain/repository/database_response.dart';
import '../../domain/repository/favorites_repository.dart';
import '../datasource/local/DAOs/database.dart';
import '../model/card_model.dart';

class FavoritesRepositoryImpl extends FavoritesRepository
    with ParseDatabaseResponse {
  final Database _database;

  FavoritesRepositoryImpl(this._database);

  @override
  Future<CardEvent> saveFavoriteCard(CardModel card) async {
    Map<String, dynamic> mapCard = CardModel.toJson(card);
    try {
      CardEvent dbCard = await getFavoriteCard(card);
      if (dbCard.isFavorite == false) {
        await database.addCard(
          cards: [mapCard],
          mainCollectionDocument: StringConstants.favoritesDocument,
          subcollection: StringConstants.favoritesSubcollection,
        );
        return CardEvent(
          status: Status.success,
          isFavorite: true,
        );
      } else {
        await database.deleteCard(docId: card.cardId!);
        return CardEvent(
          status: Status.success,
          isFavorite: false,
        );
      }
    } catch (e) {
      return CardEvent(
        status: Status.error,
        errorMsg: "$e",
      );
    }
  }

  @override
  Future<CardEvent> getFavoriteCard(CardModel card) async {
    QuerySnapshot favorites = await database.readCards(
      mainCollectionDocument: StringConstants.favoritesDocument,
      subcollection: StringConstants.favoritesSubcollection,
    );
    if (favorites.docs.isEmpty) {
      return CardEvent(
        status: Status.success,
        isFavorite: false,
      );
    } else {
      for (var dbCard in favorites.docs) {
        if (dbCard["cardId"] == card.cardId) {
          return CardEvent(
            status: Status.success,
            isFavorite: true,
          );
        }
      }
      return CardEvent(
        status: Status.success,
        isFavorite: false,
      );
    }
  }

  @override
  Future<CardEvent> fetchFavoriteCards() async {
    return await parseDatabaseResponse(
      document: StringConstants.favoritesDocument,
      specificEndpoint: StringConstants.favoritesSubcollection,
    );
  }

  @override
  Database get database => _database;
}
