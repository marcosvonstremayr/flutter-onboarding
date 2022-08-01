class Card {
  final String? cardId;
  final String? dbfId;
  final String? name;
  final String? cardSet;
  final String? type;
  final String? faction;
  final String? rarity;
  final int? cost;
  final int? attack;
  final int? health;
  final int? durability;
  final int? armor;
  final String? text;
  final String? inPlayText;
  final String? flavor;
  final String? artist;
  final bool? collectible;
  final bool? elite;
  final String? race;
  final String? playerClass;
  final String? multiClassGroup;
  final String? classes;
  final String? howToGet;
  final String? howToGetGold;
  final String? img;
  final String? imgGold;
  final String? locale;
  final List<String>? mechanics;

  Card(
    this.cardId,
    this.dbfId,
    this.name,
    this.cardSet,
    this.type,
    this.faction,
    this.rarity,
    this.cost,
    this.attack,
    this.health,
    this.durability,
    this.armor,
    this.text,
    this.inPlayText,
    this.flavor,
    this.artist,
    this.collectible,
    this.elite,
    this.race,
    this.playerClass,
    this.multiClassGroup,
    this.classes,
    this.howToGet,
    this.howToGetGold,
    this.img,
    this.imgGold,
    this.locale,
    this.mechanics,
  );
}
