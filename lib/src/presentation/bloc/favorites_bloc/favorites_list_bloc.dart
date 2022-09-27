import '../../../core/bloc/bloc.dart';
import '../../../domain/entity/card_event.dart';

abstract class FavoritesListBloc extends Bloc{
  Stream<CardEvent> getStream();
  Future<void> getFavoriteCards();
  @override
  void initialize();
  @override
  void dispose();
}
