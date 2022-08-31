import 'dart:convert';
import 'dart:io';

import '../../core/util/string_constants.dart';
import '../../domain/entity/card_event.dart';
import '../../domain/repository/card_repository.dart';
import '../datasource/remote/cards_api_service.dart';
import '../model/card_model.dart';

class CardRepositoryImpl extends CardRepository {
  final CardsApiService _apiService;

  CardRepositoryImpl(
    this._apiService,
  );

  @override
  Future<CardEvent> fetchFilteredCards(endpoint) async {
    List<CardModel> cardsModels = [];
    try {
      var apiResponse = await _apiService.callApi(endpoint: endpoint);
      if (apiResponse.statusCode == HttpStatus.ok) {
        List<dynamic> cards = json.decode(apiResponse.body);
        if (cards.isEmpty) {
          return CardEvent(status: Status.empty);
        } else {
          cards.forEach((card) {
            var cardElement = CardModel.fromJson(card);
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
      return CardEvent(
        status: Status.error,
        errorMsg: StringConstants.apiError,
      );
    } catch (e) {
      return CardEvent(
        status: Status.error,
        errorMsg: StringConstants.internetConnectionError,
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
            value.forEach((card) {
              cardsModels.add(CardModel.fromJson(card));
            });
          });
          return CardEvent(
            cards: cardsModels,
            status: Status.success,
          );
        }
      }
      return CardEvent(
        status: Status.error,
        errorMsg: StringConstants.apiError,
      );
    } catch (e) {
      return CardEvent(
        status: Status.error,
        errorMsg: StringConstants.internetConnectionError,
      );
    }
  }
}
