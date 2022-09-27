import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/repository/favorites_repository.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_favorites_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../mocks.dart';
import 'get_favorite_usecase_unit_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  late FavoritesRepository favoritesRepository;
  late GetFavoritesUsecase getFavoritesUsecase;

  setUp(() {
    favoritesRepository = MockFavoritesRepository();
    getFavoritesUsecase = GetFavoritesUsecase(favoritesRepository);
  });

  group("Get Favorite Usecase Unit Tests", () {
    test("Call method", () async {
      var card = CardModel.fromJson(cardsTestsJson);
      when(favoritesRepository.fetchFavoriteCards()).thenAnswer((_) async {
        return CardEvent(
          cards: [card],
          status: Status.success,
        );
      });
      expectLater(
        await getFavoritesUsecase(),
        isA<CardEvent>(),
      );
    });
  });
}
