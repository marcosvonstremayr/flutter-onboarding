import 'dart:async';

import '../../../data/model/card_model.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entity/card_event.dart';
import 'favorite_bloc.dart';

class FavoritesBlocImpl extends FavoritesBloc {
  final Usecase _saveFavoritesUsecase;
  final Usecase _getFavoriteUsecase;

  FavoritesBlocImpl(
    this._saveFavoritesUsecase,
    this._getFavoriteUsecase,
  );

  final StreamController<CardEvent> _streamController =
      StreamController<CardEvent>.broadcast();

  @override
  Stream<CardEvent> getStream() => _streamController.stream;

  @override
  void initialize() {
    _streamController.sink.add(CardEvent(status: Status.initial));
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Future<void> saveFavoriteCard(CardModel card) async {
    _streamController.sink.add(await _saveFavoritesUsecase(params: card));
  }

  @override
  Future<void> isCardFavorite(CardModel card) async {
    _streamController.sink.add(await _getFavoriteUsecase(params: card));
  }
}
