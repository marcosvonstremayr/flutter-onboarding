import 'cards_bloc/cards_bloc.dart';
import 'favorites_bloc/favorite_bloc.dart';
import 'favorites_bloc/favorites_list_bloc.dart';

class Blocs {
  final CardsBloc _homePageBloc;
  final FavoritesListBloc _favoritesListBloc;
  final FavoritesBloc _favoriteBloc;

  Blocs(
    this._homePageBloc,
    this._favoritesListBloc,
    this._favoriteBloc,
  );

  CardsBloc get homePageBloc {
    return _homePageBloc;
  }

  FavoritesBloc get favoriteBloc {
    return _favoriteBloc;
  }

  FavoritesListBloc get favoritesListBloc {
    return _favoritesListBloc;
  }
}
