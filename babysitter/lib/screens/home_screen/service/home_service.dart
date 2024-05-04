import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<BabysitterModel>> fetchBabySitters() async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://192.168.1.17:3000/api/babysitters/demandes/acceptees"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      List result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<BabysitterModel> babysitters = [];
        for (var babysitter in result) {
          BabysitterModel user = BabysitterModel(
            id: babysitter['_id'],
            nom: babysitter['nom'],
            prenom: babysitter['prenom'],
            email: babysitter['email'],
            phone: babysitter['phone'],
            password: babysitter['password'],
            description: babysitter['description'],
            accepte: babysitter['accepte'],
          );
          babysitters.add(user);
        }

        return babysitters;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }
}
