import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:esd_mobil/view/profile/model/app_user._model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfileService {
  static ProfileService? _instance;
  static ProfileService? get instance {
    if (_instance == null) _instance = ProfileService._init();
    return _instance;
  }

  final auth = FirebaseAuth.instance;
  final apiPath =
      "https://forthfl-74350-default-rtdb.europe-west1.firebasedatabase.app/users/";

  ProfileService._init() {}

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

  Future<bool> validatePassword(String password) async {
    var firebaseUser = auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    print(authCredentials);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(
      String newPassword, String id, AppUser user) async {
    var firebaseUser = auth.currentUser;
    await firebaseUser!.updatePassword(newPassword);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'password': newPassword,
      "email": user.email,
      "name": user.name,
      "surname": user.surname,
    };
    String jsonBody = json.encode(body);
    Response response = await http.put(Uri.parse(apiPath + "$id.json"),
        headers: headers, body: jsonBody);
    print(response.statusCode);
  }
}
