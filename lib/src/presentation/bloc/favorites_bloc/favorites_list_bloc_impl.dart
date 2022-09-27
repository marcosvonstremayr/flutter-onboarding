import 'dart:async';

import '../../../core/usecases/usecase.dart';
import '../../../domain/entity/card_event.dart';
import 'favorites_list_bloc.dart';

class FavoritesListBlocImpl extends FavoritesListBloc {

  final Usecase _getFavoriteCards;

  FavoritesListBlocImpl(this._getFavoriteCards);

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
  Future<void> getFavoriteCards() async {
    _streamController.sink.add(CardEvent(status: Status.loading));
    _streamController.sink.add(await _getFavoriteCards());
  }
}
