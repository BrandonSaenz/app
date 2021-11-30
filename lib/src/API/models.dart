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

class MuscularGroupsArray {
  MuscularGroupsArray();
  static List<ModelMuscularGroups> fromJsonList(List<dynamic> jsonList) {
    List<ModelMuscularGroups> list = [];
    if (jsonList != null) {
      for (var group in jsonList) {
        final data = ModelMuscularGroups.fromJson(group);
        list.add(data);
      }
    }
    return list;
  }
}

class ModelRoutines {
  String id;
  String title;
  String description;
  String num_circuitos;
  String id_muscular_groups;

  ModelRoutines(
      {required this.id,
      required this.title,
      required this.description,
      required this.num_circuitos,
      required this.id_muscular_groups});

  static ModelRoutines fromJson(Map<String, dynamic> json) {
    return ModelRoutines(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      num_circuitos: json['num_circuitos'] as String,
      id_muscular_groups: json['id_muscular_groups'] as String,
    );
  }
}

class RoutinesArray {
  RoutinesArray();
  static List<ModelRoutines> fromJsonList(List<dynamic> jsonList) {
    List<ModelRoutines> list = [];
    if (jsonList != null) {
      for (var routine_data in jsonList) {
        final data = ModelRoutines.fromJson(routine_data);
        list.add(data);
      }
    }
    return list;
  }
}
