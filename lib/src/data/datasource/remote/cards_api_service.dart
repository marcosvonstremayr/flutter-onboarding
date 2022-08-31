import 'package:http/http.dart' as http;

import '../../../core/util/api_service_constants.dart';

class CardsApiService {
  final http.Client _client;

  CardsApiService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> callApi({endpoint}) async {
    Uri uri;
    if (endpoint != null) {
      uri = Uri.parse('${ApiServiceConstants.apiBaseUrl}$endpoint');
    } else {
      uri = Uri.parse(ApiServiceConstants.apiBaseUrl);
    }
    var response = await _client.get(
      uri,
      headers: ApiServiceConstants.apiCardsHeaders,
    );
    return response;
  }
}
