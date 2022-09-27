import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/repository/favorites_repository.dart';
import 'package:hearthstone_cards/src/domain/usecase/save_favorites_usecase.dart';
import 'package:mockito/mockito.dart';
import '../../mocks.dart';
import 'package:mockito/annotations.dart';
import 'save_favorites_usecase_unit_test.mocks.dart';


@GenerateMocks([FavoritesRepository])
void main() {
  late FavoritesRepository favoritesRepository;
  late SaveFavoritesUsecase saveFavoritesUsecase;

  setUp(() {
    favoritesRepository = MockFavoritesRepository();
    saveFavoritesUsecase = SaveFavoritesUsecase(favoritesRepository);
  });

  group("Get Favorite Usecase Unit Tests", () {
    test("Call method", () async {
      var card = CardModel.fromJson(cardsTestsJson);
      when(favoritesRepository.saveFavoriteCard(card)).thenAnswer((_) async {
        return CardEvent(
          status: Status.success,
          isFavorite: true,
        );
      });
      expectLater(
        await saveFavoritesUsecase(params: card),
        isA<CardEvent>(),
      );
    });
  });
}
