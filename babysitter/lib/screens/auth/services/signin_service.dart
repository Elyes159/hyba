import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:babysitter/screens/auth/models/parent_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SigninService {
  Future<String> signin(
    String type,
    String email,
    String password,
  ) async {
    try {
      if (type == 'baby-sitter') {
        var response = await http.post(
          Uri.parse("http://192.168.1.17:3000/api/babysitters/login"),
          body: json.encode({"email": email, "password": password}),
          headers: {
            "Content-Type": "application/json",
          },
        );
        print(response.body);
        var signupJson = json.decode(response.body.toString());
        if (response.statusCode == 200) {
          BabysitterModel user = BabysitterModel.fromJson(signupJson);
          GetStorage().write('babysitter', user.toJson());
          return 'success';
        } else {
          return signupJson['message'];
        }
      } else {
        var response = await http.post(
          Uri.parse("http://192.168.1.17:3000/api/parents/login"),
          body: json.encode({"email": email, "password": password}),
          headers: {
            "Content-Type": "application/json",
          },
        );
        print(response.body);
        var signupJson = json.decode(response.body.toString());
        if (response.statusCode == 200) {
          ParentModel user = ParentModel.fromJson(signupJson);
          GetStorage().write('parent', user.toJson());
          return 'success';
        } else {
          return signupJson['message'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }
}
