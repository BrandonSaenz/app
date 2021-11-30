import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class GetFenrirUsers {
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

class GetMuscularGroups {
  // ignore: non_constant_identifier_names
  static final String API_url = "http://fenrir.com.mx/muscular_groups/get.php";

  static Future<List<ModelMuscularGroups>> getList() async {
    var url = API_url;
    List<ModelMuscularGroups> dataUsers = [];
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final respJSON = json.decode(resp.body);
      if (respJSON['muscular_groups'] != null) {
        dataUsers =
            MuscularGroupsArray.fromJsonList(respJSON['muscular_groups']);
      }
      return dataUsers;
    }
    return dataUsers;
  }
}

class GetRoutines {
  // ignore: non_constant_identifier_names

  static Future<List<ModelRoutines>> getList(String id) async {
    String API_url =
        "http://fenrir.com.mx/routines/get.php?id_muscular_groups=${id}";
    var url = API_url;
    List<ModelRoutines> dataUsers = [];
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final respJSON = json.decode(resp.body);
      if (respJSON['routines'] != null) {
        dataUsers = RoutinesArray.fromJsonList(respJSON['routines']);
      }
      return dataUsers;
    }
    return dataUsers;
  }
}
