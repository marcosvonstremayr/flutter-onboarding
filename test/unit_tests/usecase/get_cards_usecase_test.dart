import 'package:hearthstone_cards/src/core/usecases/usecase.dart';
import 'package:hearthstone_cards/src/core/util/api_service_constants.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/repository/card_repository.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_cards_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import 'get_cards_usecase_test.mocks.dart';

@GenerateMocks([CardRepository])
void main (){
  late MockCardRepository cardRepository;
  late Usecase getCardsUsecase;

  setUp(() {
    cardRepository = MockCardRepository();
    getCardsUsecase = GetCardsUsecase(cardRepository);
  });

  group("Get Cards Usecase Unit Tests", () {
    test("Call method without endpoint", () async {
      List<CardModel> cardModelList = [CardModel.fromJson(cardsTestsJson)];
      when(cardRepository.fetchAllCards()).thenAnswer((_) async{
        return CardEvent(cards: cardModelList, status: Status.success);
      });
      expectLater(await getCardsUsecase(), isA<CardEvent>());
    });
    test("Call method with endpoint", () async {
      List<CardModel> cardModelList = [CardModel.fromJson(cardsTestsJson)];
      String? endpoint = ApiServiceConstants.apiCardsQualityEndpoint["Free"];
      when(cardRepository.fetchFilteredCards(endpoint)).thenAnswer((_) async{
        return CardEvent(cards: cardModelList, status: Status.success);
      });
      expectLater(await getCardsUsecase(endpoint: endpoint), isA<CardEvent>());
    });
  });
}
