import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/config/notification_service/local_notification_service.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/presentation/bloc/blocs.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorites_list_bloc.dart';
import 'package:hearthstone_cards/src/presentation/view/favorites.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mocks.dart';
import 'favorites_widget_test.mocks.dart';

@GenerateMocks([Blocs, FavoritesListBloc, LocalNotificationService])
void main() {
  Blocs blocs = MockBlocs();
  FavoritesListBloc favoritesBloc = MockFavoritesListBloc();
  LocalNotificationService service = MockLocalNotificationService();
  StreamController<CardEvent> streamController = StreamController();

  tearDown(() {
    favoritesBloc.dispose();
  });

  Widget _buildWidget() {
    return MaterialApp(
      home: Favorites(
        blocs: blocs,
        service: service,
      ),
    );
  }

  testWidgets("Seeing favorites elements", (WidgetTester tester) async {
    await mockNetworkImages(() async {
      when(blocs.favoritesListBloc).thenAnswer((_) {
        return favoritesBloc;
      });
      when(favoritesBloc.getStream()).thenAnswer((_) {
        return streamController.stream;
      });
      await tester.pumpWidget(_buildWidget());
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      streamController.sink.add(
        CardEvent(
          cards: [CardModel.fromJson(cardsTestsJson)],
          status: Status.success,
        ),
      );
      await tester.pumpWidget(_buildWidget());
      expect(
        find.byType(Image),
        findsOneWidget,
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
        find.byType(Image),
        findsWidgets,
      );
    });
  });
}
