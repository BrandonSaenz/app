import 'package:app/src/models/users_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMuscularGroups {
  // ignore: non_constant_identifier_names
  static final String API_url = "http://fenrir.com.mx/users/get.php";

  static Future<List<ModelUsers>> getListUsers() async {
    var url = API_url;
    List<ModelUsers> dataUsers = [];
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final respJSON = json.decode(resp.body);
      if (respJSON['users'] != null) {
        dataUsers = Users.fromJsonList(respJSON['users']);
      }
      return dataUsers;
    }
    return dataUsers;
  }
}
