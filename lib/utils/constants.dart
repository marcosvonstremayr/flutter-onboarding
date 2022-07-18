import 'package:flutter/material.dart';

abstract class Constants {
  static const String appTitle = "Hearthstone App";
  static const String appFont = "MedievalSharp";
  static var appBackgroundColor = Colors.orange[100];
  static const String pathToImageCard = 'assets/images/ysera_card.png';
  static const double cardHeight = 500;
  static const double likeIconSize = 30;
  static const double likeCounterFontSize = 30;
  static const double cardTextPadding = 8;
  static const cardTextColor = Colors.black;
  static const double cardTextFontSize = 24;
  static const verticalDividerColor = Colors.black;
  static const double verticalDividerThickness = 2;
  static const int cardTextAbilityMaxLines = 6;
  static const cardTextAbilityOverflow = TextOverflow.ellipsis;
  static const double sizedBoxHeight = 100;
  static const likeButtonColor = Colors.pink;
  static const double iconPadding = 10;
  static const String cardName = "Name: Ysera";
  static const String cardType = "Type: Minion";
  static const String cardFaction = "Faction: Neutral";
  static const String cardRarity = "Rarity: Legendary";
  static const String cardCost = "Cost: 9";
  static const String cardAttack = "Attack: 4";
  static const String cardHealth = "Health: 12";
  static const String cardAbility =
      "Ability: At the end of your turn, add a Dream Card to your hand";
}
