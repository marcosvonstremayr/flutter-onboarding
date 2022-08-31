import 'dart:async';

import '../../../domain/entity/card_event.dart';
import '../../../core/usecases/usecase.dart';
import 'cards_bloc.dart';

class CardsBlocImpl extends CardsBloc {
  final Usecase _getCardsUsecase;

  CardsBlocImpl(this._getCardsUsecase,);

  final StreamController<CardEvent> _cardsStreamController = StreamController();

  @override
  Stream<CardEvent> getStream() => _cardsStreamController.stream;

  @override
  void dispose() {
    _cardsStreamController.close();
  }

  @override
  Future<void> getFilteredCards(endpoint) async {
    _cardsStreamController.sink.add(
      CardEvent(status: Status.loading),
    );
    _cardsStreamController.sink.add(await _getCardsUsecase(endpoint: endpoint));
    }

  @override
  Future<void> getAllCards() async {
    _cardsStreamController.sink.add(
      CardEvent(status: Status.loading),
    );
    _cardsStreamController.sink.add(await _getCardsUsecase());
  }

  @override
  void initialize() {
    _cardsStreamController.sink.add(CardEvent(status: Status.initial));
  }
}
