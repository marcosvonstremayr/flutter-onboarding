import "package:flutter_test/flutter_test.dart";
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import '../mocks.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group("CardModel testing", () {
    test("CardModel from Json instantiation", () {
      expect(CardModel.fromJson(cardsTestsJson), isInstanceOf<CardModel>());
    });
    test("Empty CardModel caused by corrupted json", () {
      expect(
        CardModel.fromJson(cardsCorruptedTestsJson),
        isInstanceOf<CardModel>(),
      );
    });
  });
}
