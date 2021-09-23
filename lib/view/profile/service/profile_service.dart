import 'dart:convert';

import 'package:fluttermvvmtemplate/view/profile/model/app_user._model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static ProfileService? _instance;
  static ProfileService? get instance {
    if (_instance == null) _instance = ProfileService._init();
    return _instance;
  }

  ProfileService._init();

  Future<AppUser> getUserById(String id) async {
    var response = await http.get(Uri.parse(
        "https://forthfl-74350-default-rtdb.europe-west1.firebasedatabase.app/users/$id.json"));
    if (response.statusCode == 200) {
      final decodedResult = json.decode(response.body);
      AppUser user = AppUser.fromJson(decodedResult);

      return user;
    }

    throw Exception(response);
  }
}
