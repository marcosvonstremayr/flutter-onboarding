import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/repository/favorites_repository.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_favorite_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../mocks.dart';
import 'get_favorite_usecase_unit_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  late FavoritesRepository favoritesRepository;
  late GetFavoriteUsecase getFavoriteUsecase;

  setUp(() {
    favoritesRepository = MockFavoritesRepository();
    getFavoriteUsecase = GetFavoriteUsecase(favoritesRepository);
  });

  group("Get Favorite Usecase Unit Tests", () {
    test("Call method", () async {
      var card = CardModel.fromJson(cardsTestsJson);
      when(favoritesRepository.getFavoriteCard(card)).thenAnswer((_) async {
        return CardEvent(
          status: Status.success,
          isFavorite: true,
        );
      });
      expectLater(
        await getFavoriteUsecase(params: card),
        isA<CardEvent>(),
      );
    });
  });
}
