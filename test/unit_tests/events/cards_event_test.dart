import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';

void main() {
  late CardEvent cardEvent;

  setUp(() {
    cardEvent = CardEvent(status: Status.initial);
  });

  group("Card Event Unit Testing", () {
    test("Card Event Correct Instantiation Test", () {
      expect(
        cardEvent,
        isInstanceOf<CardEvent>(),
      );
    });
  });
}
