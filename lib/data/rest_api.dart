import 'dart:convert';
import 'dart:developer';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RestApi {
  String hostUrl;

  RestApi({this.hostUrl = ''});

  Future<Map<String, String>> headers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return {
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      "Content-Type": "application/json; charset=utf-8",
    };
  }

  Future<String?> post(relativeUrl, values) async {
    Map<String, String> headers = await RestApi().headers();

    Uri url = Uri.parse(hostUrl + relativeUrl);
    Future<http.Response> response = http.post(
      url,
      headers: headers,
      body: json.encode(values),
    );
    return await parseResponse(
      response,
      relativeUrl,
      'POST',
      json.encode(values),
    );
  }

  Future<String?> postFiles(
    String relativeUrl,
    Map<String, String> values,
    List<http.MultipartFile> files, {
    bool allowHeic = true,
  }) async {
    try {
      Map<String, String> headers = await RestApi().headers();
      headers['Content-Type'] = 'multipart/form-data';
      Uri url = Uri.parse(hostUrl + relativeUrl);
      var request =
          http.MultipartRequest('POST', url)
            ..fields.addAll(values)
            ..headers.addAll(headers)
            ..files.addAll(files);
      var response = await request.send();
      var body = await response.stream.bytesToString();
      log("Multimedia response: $body");
      return body;
    } catch (e) {
      log("Multimedia error: $e");
      rethrow;
    }
  }

  Future<String?> put(relativeUrl, values) async {
    Map<String, String> headers = await RestApi().headers();
    Uri url = Uri.parse(hostUrl + relativeUrl);
    Future<http.Response> response = http.put(
      url,
      headers: headers,
      body: json.encode(values),
    );
    return await parseResponse(
      response,
      relativeUrl,
      'PUT',
      json.encode(values),
    );
  }

  Future<String?> get(relativeUrl) async {
    Map<String, String> headers = await RestApi().headers();
    Uri url = Uri.parse(hostUrl + relativeUrl);
    Future<http.Response> response = http.get(url, headers: headers);
    return await parseResponse(response, relativeUrl, 'GET', '');
  }

  Future<String?> delete(relativeUrl) async {
    Map<String, String> headers = await RestApi().headers();
    Uri url = Uri.parse(hostUrl + relativeUrl);
    Future<http.Response> response = http.delete(url, headers: headers);
    return await parseResponse(response, relativeUrl, 'DELETE', '');
  }

  Future<String?> parseResponse(
    Future<http.Response> petition,
    String relativeUrl,
    String method,
    String body,
  ) async {
    try {
      http.Response response = await petition;
      log('Response: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.body;
      } else {
        try {
          Map<String, dynamic> responseJson = jsonDecode(response.body);
          Map<String, Object> resume = {
            "relativeUrl": relativeUrl,
            "payload": body,
            "method": method,
            "statusCode": response.statusCode,
            "response": responseJson.toString(),
          };
        } catch (e) {
          if (e is Exception) {
            throw ExceptionEntity.fromException(e);
          } else {
            throw ExceptionEntity();
          }
        }
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw ExceptionEntity(
          code: KeyWordsLocalization.server_error_no_connection_error,
        );
      }
      rethrow;
    }
  }
}
