import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/util/string_constants.dart';
import '../../domain/entity/card_event.dart';
import '../../domain/repository/card_repository.dart';
import '../datasource/local/DAOs/database.dart';
import '../datasource/remote/cards_api_service.dart';
import '../model/card_model.dart';

class CardRepositoryImpl extends CardRepository {
  final CardsApiService _apiService;

  CardRepositoryImpl(this._apiService);

  @override
  Future<CardEvent> fetchFilteredCards(endpoint) async {
    List<CardModel> cardsModels = [];
    int startIndex = endpoint.indexOf("/");
    int endIndex = endpoint.lastIndexOf("/");
    String document = endpoint.substring(startIndex + 1, endIndex);
    String specificEndpoint = endpoint.substring(endIndex + 1);

    try {
      var apiResponse = await _apiService.callApi(endpoint: endpoint);
      if (apiResponse.statusCode == HttpStatus.ok) {
        List<dynamic> cards = json.decode(apiResponse.body);
        if (cards.isEmpty) {
          return CardEvent(status: Status.empty);
        } else {
          Database.addCard(
            cards: cards,
            mainCollectionDocument: document,
            subcollection: specificEndpoint,
          );
          cards.forEach((card) {
            var cardElement = CardModel.fromJson(card as Map);
            if (cardElement.cardId != null) {
              cardsModels.add(cardElement);
            }
          });
          return CardEvent(
            cards: cardsModels,
            status: Status.success,
          );
        }
      }
      return parseDatabaseResponse(
        document: document,
        specificEndpoint: specificEndpoint,
      );
    } catch (e) {
      return parseDatabaseResponse(
        document: document,
        specificEndpoint: specificEndpoint,
      );
    }
  }

  @override
  Future<CardEvent> fetchAllCards() async {
    List<CardModel> cardsModels = [];
    try {
      var apiResponse = await _apiService.callApi();
      if (apiResponse.statusCode == HttpStatus.ok) {
        Map<String, dynamic> cards = json.decode(apiResponse.body);
        if (cards.isEmpty) {
          return CardEvent(status: Status.empty);
        } else {
          cards.forEach((key, value) {
            Database.addCard(
              cards: value,
              mainCollectionDocument: StringConstants.allCardsDocument,
              subcollection: StringConstants.allCardsSubcollection,
            );
            value.forEach((card) async {
              var cardElement = CardModel.fromJson(card);
              if (cardElement.cardId != null) {
                cardsModels.add(cardElement);
              }
            });
          });
          return CardEvent(
            cards: cardsModels,
            status: Status.success,
          );
        }
      }
      return parseDatabaseResponse(
        document: StringConstants.allCardsDocument,
        specificEndpoint: StringConstants.allCardsSubcollection,
      );
    } catch (e) {
      return parseDatabaseResponse(
        document: StringConstants.allCardsDocument,
        specificEndpoint: StringConstants.allCardsSubcollection,
      );
    }
  }

  Future<CardEvent> parseDatabaseResponse({
    required String document,
    required String specificEndpoint,
  }) async {
    List<CardModel> cardsModels = [];
    try {
      QuerySnapshot dbResponse = await Database.readCards(
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
