import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter/models/users.dart';
import 'dart:convert' as json;

import 'api_urls.dart';

class ApiServices {
  Future<List<User>> fetchUser() {
    return http.get(ApiUrls().API_USER_LIST).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        throw Exception("Lỗi load api");
      }

      const JsonDecoder decoder = JsonDecoder();
      final useListContainer = decoder.convert(jsonBody);
      final List userList = useListContainer['results'];
      return userList.map((contactRaw) => User.fromJson(contactRaw)).toList();
    });
  }
}
