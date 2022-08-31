import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/core/util/string_constants.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/presentation/bloc/cards_bloc/cards_bloc.dart';
import 'package:hearthstone_cards/src/presentation/view/homepage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../mocks.dart';
import 'homepage_widget_test.mocks.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

@GenerateMocks([CardsBloc])
void main() {
  CardsBloc bloc = MockCardsBloc();
  StreamController<CardEvent> streamController = StreamController();
  CardEvent cardEvent = CardEvent(
    cards: [CardModel.fromJson(cardsTestsJson)],
    status: Status.success,
  );

  tearDown(() {
    bloc.dispose();
  });

  Widget _buildWidget() {
    return MaterialApp(
      home: Homepage(
        bloc: bloc,
      ),
    );
  }

  testWidgets(
      'When tapping on drawer item the UI rebuilds and creates grid with elements',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      when(bloc.getStream()).thenAnswer((_) {
        return streamController.stream;
      });
      when(bloc.getAllCards()).thenAnswer((_) async {
        streamController.sink.add(cardEvent);
      });
      await tester.pumpWidget(_buildWidget());
      expect(
        find.byType(Image),
        findsOneWidget,
      );
      await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)),
        const Offset(300, 0),
      );
      await tester.pump();
      final allCards = find.text(StringConstants.drawerListTileAllCards);
      expect(
        allCards,
        findsOneWidget,
      );
      expect(
        find.text(StringConstants.drawerListTileClassCards),
        findsOneWidget,
      );
      expect(
        find.text(StringConstants.drawerListTileQualityCards),
        findsOneWidget,
      );
      await tester.tap(allCards);
      await tester.pump();
      expect(
        find.text("Kingsbane"),
        findsOneWidget,
      );
      expect(
        find.text("Kobolds & Catacombs"),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsWidgets,
      );
      streamController.sink.add(CardEvent(status: Status.loading));
      await tester.pumpWidget(_buildWidget());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      streamController.sink.add(
        CardEvent(
          status: Status.error,
          errorMsg: StringConstants.apiError,
        ),
      );
      await tester.pumpWidget(_buildWidget());
      expect(
        find.text(StringConstants.apiError),
        findsOneWidget,
      );
      streamController.sink.add(
        CardEvent(
          status: Status.empty,
          errorMsg: StringConstants.noCardsFound,
        ),
      );
      await tester.pumpWidget(_buildWidget());
      expect(
        find.text(StringConstants.noCardsFound),
        findsOneWidget,
      );
    });
  });
}
