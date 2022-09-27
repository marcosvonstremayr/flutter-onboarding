import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_favorite_usecase.dart';
import 'package:hearthstone_cards/src/domain/usecase/save_favorites_usecase.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorite_bloc.dart';
import 'package:hearthstone_cards/src/presentation/bloc/favorites_bloc/favorite_bloc_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import 'favorite_bloc.mocks.dart';

@GenerateMocks([GetFavoriteUsecase, SaveFavoritesUsecase])
void main() {
  late GetFavoriteUsecase getFavoriteUsecase;
  late SaveFavoritesUsecase saveFavoritesUsecase;
  late FavoritesBloc bloc;
  late CardModel card;

  setUp(() {
    getFavoriteUsecase = MockGetFavoriteUsecase();
    saveFavoritesUsecase = MockSaveFavoritesUsecase();
    bloc = FavoritesBlocImpl(saveFavoritesUsecase, getFavoriteUsecase);
    card = CardModel.fromJson(cardsTestsJson);
  });

  tearDown(() {
    bloc.dispose();
  });

  group("Favorite bloc unit tests", () {
    test("Get Stream", () {
      Stream stream = bloc.getStream();
      expect(
        stream,
        isA<Stream>(),
      );
    });

    test("Favorites bloc save favorite card", () async {
      when(saveFavoritesUsecase(params: card)).thenAnswer((_) async {
        return CardEvent(
          status: Status.success,
          isFavorite: true,
        );
      });
      Stream stream = bloc.getStream();
      expect(
        stream,
        emits(isA<CardEvent>()),
      );
      await bloc.saveFavoriteCard(card);
    });

    test("Favorites bloc is card favorite", () async {
      when(getFavoriteUsecase(params: card)).thenAnswer((_) async {
        return CardEvent(
          status: Status.success,
          isFavorite: true,
        );
      });
      Stream stream = bloc.getStream();
      expect(
        stream,
        emits(isA<CardEvent>()),
      );
      await bloc.isCardFavorite(card);
    });

  });
}
