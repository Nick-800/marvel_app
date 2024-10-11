import 'dart:convert';
import 'dart:io';

import 'package:marvel_app/helpers/functions_helper.dart';
import 'package:marvel_app/models/user_model.dart';
import 'package:marvel_app/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  bool authenticated = false;
  UserModel? user;

  initializeAuthProvider() async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");
    printDebug("THE TOKEN  $token");
    authenticated = (token != null);

    setIsFailed(false);
  }

  Future<bool> signup(Map body) async {
    setIsLoading(true);
    final res = await api.post("https://lati.kudo.ly/api/register", body);
    if (res.statusCode == 200) {
      setIsFailed(false);
      return true;
    } else {
      printDebug("FFFFFFFFF");
      setIsFailed(true);
    }
    printDebug(res.body);

    setIsLoading(false);
    return false;
  }

  Future<bool> login(Map body) async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    printDebug("BEFORE POST REQ");
    final res = await api.post("https://lati.kudo.ly/api/login", body);
    if (res.statusCode == 200) {
      pref.setString("token", jsonEncode(jsonDecode(res.body)['access_token']));
      authenticated = true;
      printDebug(
          "AFTER POST REQ   TOKEN = ${jsonDecode(res.body)['access_token']} ");

      setIsFailed(false);
      return true;
    } else {
      printDebug("FFFFFFFFF");
      setIsFailed(true);
    }

    setIsLoading(false);
    return false;
  }

  Future<bool> logout() async {
    final res = await api.post("https://lati.kudo.ly/api/logout", {});

    printDebug(res.body);
    printDebug(res.headers.toString());
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

    return true;
  }

  reNewToken() {}
  Future<UserModel?> getMe() async {
    setIsLoading(true);
    final res = await api.get(
      "https://lati.kudo.ly/api/user",
    );

    if (res.statusCode == 200) {
      user = UserModel.fromJson(jsonDecode(res.body)['data']);
      printDebug("${user?.toJson()}");
      setIsLoading(false);
      return user;
    } else {
      setIsLoading(false);
      printDebug(res.body);
      return null;
    }
  }

  Future<bool> updateUser(Map body) async {
    setIsLoading(true);
    final res = await api.put("https://lati.kudo.ly/api/users/update", body);

    if (res.statusCode == 200) {
      printDebug(res.body);
      setIsLoading(false);
      getMe();
      return true;
    } else {
      printDebug(res.body);
      setIsLoading(false);
      return false;
    }
  }

  updateUserPhoto(File file) async {
    await api.upload(file, "https://lati.kudo.ly/api/uploader").then((res) {
      if (res.statusCode == 200) {
        UserModel newUM = user!;
        newUM.avatarUrl = jsonDecode(res.body)['image_name'];
        updateUser({'avatar_url': newUM.avatarUrl.toString()});
      }
    });
  }
}
