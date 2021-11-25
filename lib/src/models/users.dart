import 'package:app/src/models/get_user.dart';

class Users {
  Users();
  static List<GetUser> fromJsonList(List<dynamic> jsonList) {
    List<GetUser> listUsers = [];
    if (jsonList != null) {
      for (var user in jsonList) {
        final dataUser = GetUser.fromJson(user);
        listUsers.add(dataUser);
      }
    }
    return listUsers;
  }
}
