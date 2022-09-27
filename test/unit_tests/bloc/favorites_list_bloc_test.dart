import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_favorites_usecase.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorites_list_bloc.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorites_list_bloc_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import 'favorites_list_bloc_test.mocks.dart';

@GenerateMocks([GetFavoritesUsecase])
void main() {
  late GetFavoritesUsecase getFavoritesUsecase;
  late FavoritesListBloc favoritesBloc;

  setUp(() {
    getFavoritesUsecase = MockGetFavoritesUsecase();
    favoritesBloc = FavoritesListBlocImpl(getFavoritesUsecase);
  });

  tearDown(() => favoritesBloc.dispose());

  group("Favorites list bloc unit testing", () {
    test("Get Stream", () {
      Stream stream = favoritesBloc.getStream();
      expect(
        stream,
        isA<Stream>(),
      );
    });

    test("Favorites list bloc get favorite cards", () async {
      when(getFavoritesUsecase()).thenAnswer((_) async {
        return CardEvent(
          cards: [CardModel.fromJson(cardsTestsJson)],
          status: Status.success,
        );
      });
      Stream stream = favoritesBloc.getStream();
      expect(
        stream,
        emits(isA<CardEvent>()),
      );
      await favoritesBloc.getFavoriteCards();
    });

    test("Card event with error", () async {
      when(getFavoritesUsecase()).thenAnswer((_) async {
        return CardEvent(
          status: Status.error,
          errorMsg: "Error occurred",
        );
      });
      Stream stream = favoritesBloc.getStream();
      expect(
        stream,
        emits(isA<CardEvent>()),
      );
      await favoritesBloc.getFavoriteCards();
    });

    test("Card event with emtpy list", () async {
      when(getFavoritesUsecase()).thenAnswer((_) async {
        return CardEvent(
          status: Status.empty,
        );
      });
      Stream stream = favoritesBloc.getStream();
      expect(
        stream,
        emits(isA<CardEvent>()),
      );
      await favoritesBloc.getFavoriteCards();
    });
  });
}
