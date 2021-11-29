class ModelMuscularGroups {
  String id;
  String name;

  ModelMuscularGroups({required this.id, required this.name});

  static ModelMuscularGroups fromJson(Map<String, dynamic> json) {
    return ModelMuscularGroups(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class Users {
  Users();
  static List<ModelMuscularGroups> fromJsonList(List<dynamic> jsonList) {
    List<ModelMuscularGroups> list = [];
    if (jsonList != null) {
      for (var user in jsonList) {
        final data = ModelMuscularGroups.fromJson(user);
        list.add(data);
      }
    }
    return list;
  }
}
