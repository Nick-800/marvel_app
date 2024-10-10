import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:marvel_app/helpers/functions_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> get(String url) async {
    refreshToken();
    final response = await http.get(Uri.parse(url));

    return response;
  }

  Future<Response> post(String url, Map body) async {
        refreshToken();

    printDebug(body as String);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString("token");

    final response = await http.post(Uri.parse(url), body: body, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }

  Future<Response> put(String url, Map body) async {
        refreshToken();

    final response = await http.post(Uri.parse(url), body: jsonEncode(body));

    return response;
  }

  Future<bool> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? oldToken = prefs.getString("token");
    printDebug("REFRESH OLD TOKEN: $oldToken");
    final response = await http
        .post(Uri.parse("https://lati.kudo.ly/api/refresh"), headers: {
      "Accept": 'application/json',
      "content-type": "application/json",
      "Authorization": "Bearer $oldToken"
    });
    if (response.statusCode == 200) {
      var decodedToken = json.decode(response.body)['access_token'];
      prefs.setString("token", decodedToken);

      printDebug("REFRESH STATUS CODE: ${response.statusCode}");
      printDebug("REFRESH RESPONSE: ${response.body}");

      return true;
    } else {
      printDebug("REFRESH STATUS CODE: ${response.statusCode}");
      printDebug("REFRESH RESPONSE: ${response.body}");

      return false;
    }
  }
}
