class CardModel {
  final String cardId;
  final String dbfId;
  final String name;
  final String cardSet;
  final String type;
  final String? text;
  final int? health;
  final String playerClass;
  final String locale;
  final List<dynamic>? mechanics;

  CardModel(
    this.cardId,
    this.dbfId,
    this.name,
    this.cardSet,
    this.type,
    this.text,
    this.health,
    this.playerClass,
    this.locale,
    this.mechanics,
  );

  factory CardModel.fromJson(Map<String, dynamic> cardsJson) {
    return CardModel(
      cardsJson["cardId"],
      cardsJson["dbfId"],
      cardsJson["name"],
      cardsJson["cardSet"],
      cardsJson["type"],
      cardsJson["text"],
      cardsJson["health"],
      cardsJson["playerClass"],
      cardsJson["locale"],
      cardsJson["mechanics"],
    );
  }
}
