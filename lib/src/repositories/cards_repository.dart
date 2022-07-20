import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/card_model.dart';
import '../../utils/constants.dart';

class CardRepository {

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
