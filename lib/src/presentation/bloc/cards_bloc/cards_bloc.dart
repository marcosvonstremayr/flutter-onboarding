import '../../../core/bloc/bloc.dart';
import '../../../domain/entity/card_event.dart';

abstract class CardsBloc extends Bloc {
  Stream<CardEvent> getStream();
  Future<void> getFilteredCards(endpoint);
  Future<void> getAllCards();
  @override
  void dispose();
  @override
  void initialize();
}
