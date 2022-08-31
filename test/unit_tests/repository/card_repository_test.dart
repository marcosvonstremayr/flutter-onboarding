import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/core/util/api_service_constants.dart';
import 'package:hearthstone_cards/src/data/datasource/remote/cards_api_service.dart';
import 'package:hearthstone_cards/src/data/repository/cards_repository_impl.dart';
import 'package:hearthstone_cards/src/domain/entity/card_event.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../mocks.dart';
import 'card_repository_test.mocks.dart';

@GenerateMocks([CardsApiService])
void main() {
  late MockCardsApiService apiService;
  late CardRepositoryImpl cardRepositoryImpl;

  setUpAll(() {
    apiService = MockCardsApiService();
    cardRepositoryImpl = CardRepositoryImpl(apiService);
  });

  group("Card Repository Unit Testing", () {
    test('Test CardRepository fetchFilteredCards', () async {
      when(
        apiService.callApi(endpoint: ApiServiceConstants.apiCardsQualityEndpoint["Free"]),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestsJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl
            .fetchFilteredCards(ApiServiceConstants.apiCardsQualityEndpoint["Free"]),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository fetchAllCards', () async {
      when(
        apiService.callApi(),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestsJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl
            .fetchAllCards(),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository fetchAllCards empty json', () async {
      when(apiService.callApi()).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestEmptyJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl.fetchAllCards(),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository fetchFilteredCards empty json', () async {
      when(apiService.callApi(endpoint: ApiServiceConstants.apiCardsQualityEndpoint["Free"])).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestEmptyJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl.fetchFilteredCards(ApiServiceConstants.apiCardsQualityEndpoint["Free"]),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository fetchAllCards corrupted json', () async {
      when(apiService.callApi()).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsCorruptedTestsJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl.fetchAllCards(),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository fetchFilteredCards corrupted json', () async {
      when(apiService.callApi(endpoint: ApiServiceConstants.apiCardsQualityEndpoint["Free"])).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsCorruptedTestsJson),
          HttpStatus.ok,
        );
      });
      expect(
        await cardRepositoryImpl.fetchFilteredCards(ApiServiceConstants.apiCardsQualityEndpoint["Free"]),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository.fetchAllCards no internet connection', () async {
      when(apiService.callApi()).thenAnswer((_) async {
        return http.Response("", HttpStatus.badGateway);
      });
      expect(
        await cardRepositoryImpl.fetchAllCards(),
        isA<CardEvent>(),
      );
    });

    test('Test CardRepository.fetchFiltered bad request', () async {
      when(apiService.callApi(endpoint: ApiServiceConstants.apiCardsQualityEndpoint["Free"])).thenAnswer((_) async {
        return http.Response("", HttpStatus.badGateway);
      });
      expect(
        await cardRepositoryImpl.fetchFilteredCards(ApiServiceConstants.apiCardsQualityEndpoint["Free"]),
        isA<CardEvent>(),
      );
    });
  });
}
