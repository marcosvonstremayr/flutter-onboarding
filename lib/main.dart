import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'src/presentation/bloc/cards_bloc/cards_bloc.dart';
import 'src/core/usecases/usecase.dart';
import 'src/data/datasource/remote/cards_api_service.dart';
import 'src/data/repository/cards_repository_impl.dart';
import 'src/domain/repository/card_repository.dart';
import 'src/domain/usecase/get_cards_usecase.dart';
import 'src/presentation/bloc/cards_bloc/cards_bloc_impl.dart';
import 'src/core/util/constants.dart';
import 'src/presentation/view/homepage.dart';
import 'src/core/util/string_constants.dart';


void main() => runApp(const HearthstoneApp());

class HearthstoneApp extends StatefulWidget {
  const HearthstoneApp({Key? key}) : super(key: key);

  @override
  State<HearthstoneApp> createState() => _HearthstoneAppState();
}

class _HearthstoneAppState extends State<HearthstoneApp> {
  late CardsBloc _bloc;
  late Usecase _getCardsUsecase;
  late CardRepository _cardRepository;
  late CardsApiService _apiService;
  late http.Client _client;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    _apiService = CardsApiService(client: _client);
    _cardRepository = CardRepositoryImpl(_apiService);
    _getCardsUsecase = GetCardsUsecase(_cardRepository);
    _bloc = CardsBlocImpl(
      _getCardsUsecase,
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      theme: ThemeData(
        fontFamily: StringConstants.appFont,
        scaffoldBackgroundColor: Constants.appBackgroundColor,
        canvasColor: Constants.appCanvasColor,
      ),
      home: Homepage(
        bloc: _bloc,
      ),
    );
  }
}
