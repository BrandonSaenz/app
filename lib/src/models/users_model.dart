class ModelUsers {
  String id;
  String name;
  String type;

  ModelUsers({required this.id, required this.name, required this.type});

  static ModelUsers fromJson(Map<String, dynamic> json) {
    return ModelUsers(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }
}

class Users {
  Users();
  static List<ModelUsers> fromJsonList(List<dynamic> jsonList) {
    List<ModelUsers> listUsers = [];
    if (jsonList != null) {
      for (var user in jsonList) {
        final dataUser = ModelUsers.fromJson(user);
        listUsers.add(dataUser);
      }
    }
    return listUsers;
  }
}
