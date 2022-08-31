import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/presentation/view/card_detail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import '../mocks.dart';

void main() {
  Widget _buildWidget() {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings:
              RouteSettings(arguments: CardModel.fromJson(cardsTestsJson)),
          builder: (context) {
            return const CardDetail();
          },
        );
      },
    );
  }

  testWidgets('CardDetail has an img, card info and like button',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(_buildWidget());
      await tester.tap(
        find.widgetWithIcon(
          FloatingActionButton,
          Icons.favorite,
        ),
      );
      await tester.pump();
      expect(
        find.byType(Image),
        findsWidgets,
      );
      expect(
        find.text("Kingsbane"),
        findsOneWidget,
      );
      expect(
        find.text("Kobolds & Catacombs"),
        findsOneWidget,
      );
      expect(
        find.text("1", skipOffstage: false),
        findsOneWidget,
      );
    });
  });
}
