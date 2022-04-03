import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  /// GET запрос
  ///
  /// Параметры:
  /// [url] - URL адрес для выполнения запроса
  /// [headers] - необходимые заголовки
  ///
  /// Возвращаемое значение:
  /// [String] - полученное тело ответа
  /// [Exception] - статус-код не OK, возвращается статус-код и тело ответа
  static Future<String> get(String url, Map<String, String> headers) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    }
    throw Exception("Code: ${response.statusCode}\nBody: ${response.body}");
  }

  /// POST запрос
  ///
  /// Параметры:
  /// [url] - URL адрес для выполнения запроса
  /// [headers] - необходимые заголовки
  /// [body] - тело запроса в сыром виде
  ///
  /// Возвращаемое значение
  /// [String] - полученное тело ответа
  /// [Exception] - статус-код не OK, возвращается статус-код и тело ответа
  static Future<String> post(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    }
    throw Exception("Code: ${response.statusCode}\nBody: ${response.body}");
  }
}
