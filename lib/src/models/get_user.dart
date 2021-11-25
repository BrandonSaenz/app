class GetUser {
  String name;
  String type;

  GetUser({required this.name, required this.type});

  static GetUser fromJson(Map<String, dynamic> json) {
    return GetUser(
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }
}
