import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/domain/entity/card.dart';

void main() {
  late Card _card;

  setUp(() {
    _card = Card(
      cardId: "Ex_323",
      name: "Ysera",
      cardSet: "League of Explorers",
      type: "Enchantment",
      rarity: "8",
      cost: "0",
      attack: "2",
      health: "9",
      armor: "10",
      text: "+3/+3 and <b>Taunt</b>.",
      collectible: false,
      elite: true,
      playerClass: "Neutral",
      locale: "enUS",
    );
  });

  group("Card class testing", () {
    test("Card creation testing", () {
      expect(
        _card,
        isInstanceOf<Card>(),
      );
    });
  });
}
