import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/core/util/api_service_constants.dart';
import 'package:hearthstone_cards/src/core/util/string_constants.dart';
import 'package:hearthstone_cards/src/data/model/card_model.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:hearthstone_cards/src/domain/usecase/get_cards_usecase.dart';
import 'package:hearthstone_cards/src/presentation/bloc/cards_bloc/cards_bloc.dart';
import 'package:hearthstone_cards/src/presentation/bloc/cards_bloc/cards_bloc_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import 'cards_bloc_test.mocks.dart';

@GenerateMocks([GetCardsUsecase])
void main() {
  late MockGetCardsUsecase getCardsUsecaseMock;
  late CardsBloc bloc;

  setUp(() {
    getCardsUsecaseMock = MockGetCardsUsecase();
    bloc = CardsBlocImpl(getCardsUsecaseMock);
  });

  tearDown(() {
    bloc.dispose();
  });

  group("Cards Bloc Unit Testing", () {
    test("Get stream Unit test", () {
      Stream stream = bloc.getStream();
      expect(
        stream,
        isA<Stream>(),
      );
    });

    test("Cards Bloc getFilteredCards", () async {
      List<CardModel> listOfCards = [CardModel.fromJson(cardsTestsJson)];
      when(
        getCardsUsecaseMock(
          params: ApiServiceConstants.apiCardsQualityEndpoint["Free"],
        ),
      ).thenAnswer((_) async {
        return CardEvent(
          cards: listOfCards,
          status: Status.success,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<CardEvent>()),
      );
      await bloc.getFilteredCards(ApiServiceConstants.apiCardsQualityEndpoint["Free"]);
    });

    test("Cards Bloc getAllCards", () async {
      List<CardModel> listOfCards = [CardModel.fromJson(cardsTestsJson)];
      when(getCardsUsecaseMock()).thenAnswer((_) async {
        return CardEvent(
          cards: listOfCards,
          status: Status.success,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<CardEvent>()),
      );
      await bloc.getAllCards();
    });

    test("Cards Bloc where an error has occurred fetching information",
        () async {
      when(getCardsUsecaseMock()).thenAnswer((_) async {
        return CardEvent(
          status: Status.error,
          errorMsg: StringConstants.apiError,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<CardEvent>()),
      );
      await bloc.getAllCards();
    });

    test("Cards Bloc where an empty list of cards was returned", () async {
      when(getCardsUsecaseMock()).thenAnswer((_) async {
        return CardEvent(
          status: Status.empty,
          errorMsg: StringConstants.noCardsFound,
        );
      });
      Stream streamBloc = bloc.getStream();
      expect(
        streamBloc,
        emits(isA<CardEvent>()),
      );
      await bloc.getAllCards();
    });
  });
}
