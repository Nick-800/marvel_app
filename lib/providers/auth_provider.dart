import 'dart:convert';

import 'package:marvel_app/helpers/functions_helper.dart';
import 'package:marvel_app/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  bool authenticated = false;

  initializeAuthProvider() async {
    setIsLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    authenticated = (token != null);

    printDebug("Bearer Token is : $token");
    printDebug("Auth Status is : $authenticated");

    // if (token == null) {
    //   authenticated = false;
    // } else {
    //   authenticated = true;
    // }

    setIsLoading(false);
  }

  Future<List> register(Map body) async {
    setIsLoading(true);

    final response =
        await api.post("https://lati.kudo.ly/api/register", body);

    if (response.statusCode == 200) {
      setIsFailed(false);
      setIsLoading(false);

      return [true, json.decode(response.body)['data']];
    } else {
      setIsFailed(true);
      setIsLoading(false);

      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> login(Map body) async {
    setIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await api.post("https://lati.kudo.ly/api/login", body);

    if (response.statusCode == 200) {
      prefs.setString("token", json.decode(response.body)['access_token']);
      setIsFailed(false);
      setIsLoading(false);

      return [true, "Logged in successfully"];
    } else {
      prefs.clear();
      setIsFailed(true);
      setIsLoading(false);

      return [false, "Login failed!"];
    }
  }

  logout() async {
    setIsLoading(true);

    final response =
        await api.post("https://lati.kudo.ly/api/logout", {});

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      setIsFailed(false);
      setIsLoading(false);
      return true;
    } else {
      setIsFailed(true);
      setIsLoading(false);
      return false;
    }
  }

  refreshToken() {}

 Future<dynamic> getUser() async {
    setIsLoading(true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token == null) {
        setIsFailed(true);
        setIsLoading(false);
        return null;
      }

      final response = await api.get("https://lati.kudo.ly/api/user");

      if (response.statusCode == 200) {
        setIsFailed(false);
        setIsLoading(false);
        return jsonDecode(response.body)['data'];
      } else {
        setIsFailed(true);
        setIsLoading(false);
        return null;
      }
    } catch (e) {
      setIsFailed(true);
      setIsLoading(false);
      return null;
    }
  }
}
