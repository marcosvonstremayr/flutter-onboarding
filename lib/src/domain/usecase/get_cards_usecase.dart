import '../../core/usecases/usecase.dart';
import '../entity/card_event.dart';
import '../repository/card_repository.dart';

class GetCardsUsecase extends Usecase<CardEvent, String> {
  final CardRepository _cardRepository;

  GetCardsUsecase(this._cardRepository);

  @override
  Future<CardEvent> call({String? endpoint}) async {
    if (endpoint == null) {
      return await _cardRepository.fetchAllCards();
    } else {
      return await _cardRepository.fetchFilteredCards(endpoint);
    }
  }
}
