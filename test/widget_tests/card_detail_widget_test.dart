import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/config/notification_service/local_notification_service.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/presentation/bloc/blocs.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorite_bloc.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorites_list_bloc.dart';
import 'package:hearthstone_cards/src/presentation/view/card_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import '../mocks.dart';
import 'card_detail_widget_test.mocks.dart';

@GenerateMocks([LocalNotificationService, FavoritesBloc, FavoritesListBloc, Blocs])
void main() {
  LocalNotificationService localNotificationService =
      MockLocalNotificationService();
  FavoritesBloc favoritesBloc = MockFavoritesBloc();
  FavoritesListBloc favoritesListBloc = MockFavoritesListBloc();
  Blocs blocs = MockBlocs();
  StreamController<CardEvent> streamController = StreamController();
  CardModel mockedCard = CardModel.fromJson(cardsTestsJson);

  tearDown(() => favoritesBloc.dispose());

  Widget _buildWidget() {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: RouteSettings(arguments: mockedCard),
          builder: (context) {
            return CardDetail(
              blocs: blocs,
              favoriteBloc: favoritesBloc,
              service: localNotificationService,
            );
          },
        );
      },
    );
  }

  testWidgets('CardDetail has an img, card info and like button',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      when(favoritesBloc.getStream()).thenAnswer((_) {
        return streamController.stream;
      });
      when(favoritesBloc.isCardFavorite(mockedCard)).thenAnswer((_) async {
        streamController.sink
            .add(CardEvent(status: Status.success, isFavorite: true));
      });
      when(favoritesBloc.saveFavoriteCard(mockedCard)).thenAnswer((_) async {
        streamController.sink
            .add(CardEvent(status: Status.success, isFavorite: false));
      });
      await tester.pumpWidget(_buildWidget());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      streamController.sink
          .add(CardEvent(status: Status.success, isFavorite: true));
      await tester.pumpWidget(_buildWidget());
      expect(
        find.byIcon(
          Icons.favorite,
          skipOffstage: false,
        ),
        findsOneWidget,
      );
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
    });
  });
}
