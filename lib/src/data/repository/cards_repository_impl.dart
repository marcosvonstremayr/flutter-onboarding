import 'dart:convert';
import 'package:flutter/services.dart';

import '../../core/util/constants.dart';
import '../../domain/repository/card_repository.dart';
import '../model/card_model.dart';

class CardRepositoryImpl extends CardRepository {
  @override
  Future<List<CardModel>> fetchCards() async {
    List<CardModel> cardsModels = [];
    var jsonText = await rootBundle.loadString(Constants.pathToJson);
    List<dynamic> cards = json.decode(jsonText);
    cards.forEach((cardInfo) {
      cardsModels.add(CardModel.fromJson(cardInfo));
    });
    return cardsModels;
  }
}
