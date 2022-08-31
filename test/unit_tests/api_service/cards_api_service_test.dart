import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hearthstone_cards/src/core/util/api_service_constants.dart';
import 'package:hearthstone_cards/src/data/datasource/remote/cards_api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../mocks.dart';
import 'cards_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CardsApiService apiService;
  late MockClient client;

  setUp(() {
    client = MockClient();
    apiService = CardsApiService(client: client);
  });

  group("Api Service Class Unit Tests", () {
    test("Api Service call test without endpoint", () async {
      when(
        client.get(
          Uri.parse(ApiServiceConstants.apiBaseUrl),
          headers: ApiServiceConstants.apiCardsHeaders,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestsJsonFilteredCards),
          HttpStatus.ok,
        );
      });
      expect(
        await apiService.callApi(),
        isA<http.Response>(),
      );
    });

    test("Api Service call test with endpoint", () async {
      String? endpoint = ApiServiceConstants.apiCardsQualityEndpoint["Free"];
      when(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.apiBaseUrl}$endpoint',
          ),
          headers: ApiServiceConstants.apiCardsHeaders,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestsJsonFilteredCards),
          HttpStatus.ok,
        );
      });
      expect(
        await apiService.callApi(
          endpoint: ApiServiceConstants.apiCardsQualityEndpoint["Free"],
        ),
        isA<http.Response>(),
      );
    });

    test("Api Service call with error 404", () async {
      when(
        client.get(
          Uri.parse(ApiServiceConstants.apiBaseUrl),
          headers: ApiServiceConstants.apiCardsHeaders,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(cardsTestEmptyJson),
          HttpStatus.notFound,
        );
      });
      expect(
        await apiService.callApi(),
        isA<http.Response>(),
      );
    });
  });
}
