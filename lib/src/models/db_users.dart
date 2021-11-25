import 'package:app/src/models/get_user.dart';
import 'package:app/src/models/users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetFenrirUsers {
  // ignore: non_constant_identifier_names
  static final String API_url = "http://fenrir.com.mx/getUsers.php";

  static Future<List<GetUser>> getListUsers() async {
    var url = API_url;
    List<GetUser> dataUsers = [];
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final respJSON = json.decode(resp.body);
      dataUsers = Users.fromJsonList(respJSON['users']);
      return dataUsers;
    }
    return dataUsers;
  }
}
