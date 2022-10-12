import '../../domain/entity/card.dart';

class CardModel extends Card {
  CardModel({
    String? cardId,
    String? dbfId,
    String? name,
    String? cardSet,
    String? type,
    String? faction,
    String? rarity,
    String? cost,
    String? attack,
    String? health,
    String? durability,
    String? armor,
    String? text,
    String? inPlayText,
    String? flavor,
    String? artist,
    bool? collectible,
    bool? elite,
    String? race,
    String? playerClass,
    String? multiClassGroup,
    List<dynamic>? classes,
    String? howToGet,
    String? howToGetGold,
    String? img,
    String? imgGold,
    String? locale,
    List<String>? mechanics,
  }) : super(
          cardId: cardId,
          dbfId: dbfId,
          name: name,
          cardSet: cardSet,
          type: type,
          faction: faction,
          rarity: rarity,
          cost: cost,
          attack: attack,
          health: health,
          durability: durability,
          armor: armor,
          text: text,
          inPlayText: inPlayText,
          flavor: flavor,
          artist: artist,
          collectible: collectible,
          elite: elite,
          race: race,
          playerClass: playerClass,
          multiClassGroup: multiClassGroup,
          classes: classes,
          howToGet: howToGet,
          howToGetGold: howToGetGold,
          img: img,
          imgGold: imgGold,
          locale: locale,
          mechanics: mechanics,
        );

  factory CardModel.fromJson(dynamic cardsJson) {
    try {
      List<String>? mechanics;
      if (cardsJson["mechanics"] != null) {
        cardsJson["mechanics"].forEach((name) {
          mechanics?.add(name["name"]);
        });
      }
      return CardModel(
        cardId: cardsJson["cardId"],
        dbfId: cardsJson["dbfId"].toString(),
        name: cardsJson["name"],
        cardSet: cardsJson["cardSet"],
        type: cardsJson["type"],
        faction: cardsJson["faction"],
        rarity: cardsJson["rarity"],
        cost: cardsJson["cost"].toString(),
        attack: cardsJson["attack"].toString(),
        health: cardsJson["health"].toString(),
        durability: cardsJson["durability"].toString(),
        armor: cardsJson["armor"].toString(),
        text: cardsJson["text"],
        inPlayText: cardsJson["inPlayText"],
        flavor: cardsJson["flavor"],
        artist: cardsJson["artist"],
        collectible: cardsJson["collectible"],
        elite: cardsJson["elite"],
        race: cardsJson["race"],
        playerClass: cardsJson["playerClass"],
        multiClassGroup: cardsJson["multiClassGroup"],
        classes: cardsJson["classes"],
        howToGet: cardsJson["howToGet"],
        howToGetGold: cardsJson["howToGetGold"],
        img: cardsJson["img"],
        imgGold: cardsJson["imgGold"],
        locale: cardsJson["locale"],
        mechanics: mechanics,
      );
    } catch (e) {
      return CardModel();
    }
  }

  static Map<String, dynamic> toJson(CardModel card) {
    return {
      "cardId" : card.cardId,
      "dbfId": card.dbfId,
      "name": card.name,
      "cardSet": card.cardSet,
      "type": card.type,
      "faction": card.faction,
      "rarity": card.rarity,
      "cost": card.cost,
      "attack": card.attack,
      "health": card.health,
      "durability": card.durability,
      "armor": card.armor,
      "text": card.text,
      "inPlayText": card.inPlayText,
      "flavor": card.flavor,
      "artist": card.artist,
      "collectible": card.collectible,
      "elite": card.elite,
      "race": card.race,
      "playerClass": card.playerClass,
      "multiClassGroup": card.multiClassGroup,
      "classes": card.classes,
      "howToGet": card.howToGet,
      "howToGetGold": card.howToGetGold,
      "img": card.img,
      "imgGold": card.imgGold,
      "locale": card.locale,
      "mechanics": card.mechanics,
    };
  }
}
