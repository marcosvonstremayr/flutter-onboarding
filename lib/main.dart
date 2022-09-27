import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hearthstone_cards/src/data/datasource/local/DAOs/database.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

import 'src/config/notification_service/local_notification_service.dart';
import 'src/data/repository/favorites_repository_impl.dart';
import 'src/domain/repository/favorites_repository.dart';
import 'src/domain/usecase/get_favorite_usecase.dart';
import 'src/domain/usecase/save_favorites_usecase.dart';
import 'src/presentation/bloc/cards_bloc/cards_bloc.dart';
import 'src/core/usecases/usecase.dart';
import 'src/data/datasource/remote/cards_api_service.dart';
import 'src/data/repository/cards_repository_impl.dart';
import 'src/domain/repository/card_repository.dart';
import 'src/domain/usecase/get_cards_usecase.dart';
import 'src/presentation/bloc/cards_bloc/cards_bloc_impl.dart';
import 'src/core/util/constants.dart';
import 'src/presentation/bloc/favorites_bloc/favorite_bloc_impl.dart';
import 'src/presentation/bloc/favorites_bloc/favorites_list_bloc_impl.dart';
import 'src/presentation/view/homepage.dart';
import 'src/core/util/string_constants.dart';
import 'src/presentation/bloc/favorites_bloc/favorite_bloc.dart';
import 'src/domain/usecase/get_favorites_usecase.dart';
import 'src/presentation/bloc/favorites_bloc/favorites_list_bloc.dart';
import 'src/presentation/bloc/blocs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HearthstoneApp());
}

class HearthstoneApp extends StatefulWidget {
  const HearthstoneApp({Key? key}) : super(key: key);

  @override
  State<HearthstoneApp> createState() => _HearthstoneAppState();
}

class _HearthstoneAppState extends State<HearthstoneApp> {
  late CardsBloc _cardsBloc;
  late Usecase _getCardsUsecase;
  late CardRepository _cardRepository;
  late CardsApiService _apiService;
  late http.Client _client;
  late FavoritesBloc _favoritesBloc;
  late Usecase _getFavoriteUsecase;
  late Usecase _getFavoritesUsecase;
  late Usecase _saveFavoritesUsecase;
  late FavoritesRepository _favoritesRepository;
  late LocalNotificationService _localNotificationService;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late FavoritesListBloc _favoritesListBloc;
  late Blocs _blocs;
  late Database _database;

  @override
  void initState() {
    super.initState();
    _database = Database();
    _client = http.Client();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _localNotificationService =
        LocalNotificationService(_flutterLocalNotificationsPlugin);
    _localNotificationService.initialize();
    _apiService = CardsApiService(client: _client);
    _cardRepository = CardRepositoryImpl(
      _apiService,
      _database,
    );
    _getCardsUsecase = GetCardsUsecase(_cardRepository);
    _cardsBloc = CardsBlocImpl(
      _getCardsUsecase,
    );
    _favoritesRepository = FavoritesRepositoryImpl(_database);
    _getFavoriteUsecase = GetFavoriteUsecase(_favoritesRepository);
    _getFavoritesUsecase = GetFavoritesUsecase(_favoritesRepository);
    _saveFavoritesUsecase = SaveFavoritesUsecase(_favoritesRepository);
    _favoritesBloc = FavoritesBlocImpl(
      _saveFavoritesUsecase,
      _getFavoriteUsecase,
    );
    _favoritesListBloc = FavoritesListBlocImpl(_getFavoritesUsecase);
    _blocs = Blocs(
      _cardsBloc,
      _favoritesListBloc,
      _favoritesBloc,
    );
  }

  @override
  void dispose() {
    _cardsBloc.dispose();
    _favoritesBloc.dispose();
    _favoritesListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        return MaterialApp(
          title: StringConstants.appTitle,
          theme: ThemeData(
            fontFamily: StringConstants.appFont,
            scaffoldBackgroundColor: Constants.appBackgroundColor,
            canvasColor: Constants.appCanvasColor,
          ),
          home: Homepage(
            blocs: _blocs,
            service: _localNotificationService,
          ),
        );
      },
    );
  }
}
