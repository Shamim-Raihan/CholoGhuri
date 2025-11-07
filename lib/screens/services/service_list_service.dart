import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'model/service_item.dart';
import 'package:chologhuri/core/config/api_config.dart';
import 'package:chologhuri/screens/login/services/auth_storage_service.dart';

class ServiceListService {
  final String? baseUrl;
  final Logger _logger = Logger();
  final AuthStorageService _authStorage = AuthStorageService();

  ServiceListService({this.baseUrl});

  /// Fetch services for slug. Token and baseUrl are resolved internally.
  Future<List<ServiceItem>> fetchServices(String slug) async {
    try {
      final token = await _authStorage.getToken();
      final url = '${baseUrl ?? ApiConfig.baseUrl}/api/service-list/$slug';
      _logger.i('Fetching service list: $url');
      final uri = Uri.parse(url);
      final request = http.Request('GET', uri);
      if (token != null && token.isNotEmpty) {
        request.headers.addAll({'Authorization': 'Bearer $token'});
        _logger.i('Using Bearer token (length=${token.length})');
      } else {
        _logger.w(
          'No auth token found, calling service without Authorization header',
        );
      }

      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();
      _logger.i(
        'Service responded: status=${streamed.statusCode}, body=${respStr.length} chars',
      );

      if (streamed.statusCode == 200) {
        final jsonBody = json.decode(respStr) as Map<String, dynamic>;
        final dataList = jsonBody['data_list'] as List<dynamic>?;
        if (dataList == null) return [];
        final result =
            dataList
                .map((e) => ServiceItem.fromJson(e as Map<String, dynamic>))
                .toList();
        _logger.i('Parsed ${result.length} services from response');

        // Log each resolved icon/url for debugging
        for (var s in result) {
          _logger.i('Service(id=${s.id}) icon resolved to: ${s.icon}');
        }
        return result;
      }
      _logger.w('Non-200 response from service: ${streamed.statusCode}');
      return [];
    } catch (e, st) {
      _logger.e('Failed to fetch service list: $e\n$st');
      return [];
    }
  }
}
