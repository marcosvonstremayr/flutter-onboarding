import '../../../core/bloc/bloc.dart';
import '../../../data/model/card_model.dart';
import '../../../domain/entity/card_event.dart';

abstract class FavoritesBloc extends Bloc{
  Stream<CardEvent> getStream();
  Future<void> saveFavoriteCard(CardModel card);
  Future<void> isCardFavorite(CardModel card);
  @override
  void initialize();
  @override
  void dispose();
}
