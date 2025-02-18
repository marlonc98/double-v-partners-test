import 'dart:io' show Platform;

import 'package:doublevpartners/constants_private.dart';
import 'package:doublevpartners/data/rest_api.dart';
import 'package:flutter/foundation.dart';

class GmapsApi extends RestApi {
  @override
  GmapsApi({super.hostUrl = 'https://maps.googleapis.com/maps/api'});

  @override
  Future<Map<String, String>> headers() async {
    return Future.value({"Content-Type": "application/json; charset=utf-8"});
  }

  @override
  Future<String?> post(relativeUrl, values) async {
    return super.post('$relativeUrl${completeRelativeUrl()}', values);
  }

  @override
  Future<String?> put(relativeUrl, values) async {
    return super.put('$relativeUrl${completeRelativeUrl()}', values);
  }

  @override
  Future<String?> get(relativeUrl) async {
    if (kIsWeb) {
      return super.post("/gmaps", {"url": relativeUrl});
    }
    return super.get('$relativeUrl${completeRelativeUrl()}');
  }

  @override
  Future<String?> delete(relativeUrl) async {
    return super.delete('$relativeUrl${completeRelativeUrl()}');
  }

  String completeRelativeUrl() {
    String key;
    if (Platform.isIOS) {
      key = iosGmapsApiKey;
    } else {
      key = androidGmapsApiKey;
    }
    return '&key=$key';
  }
}
