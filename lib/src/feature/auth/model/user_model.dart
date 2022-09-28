class UserModel {
  final String? id;
  final String token;
  final String? name;
  final String? email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["user"]["id"].toString(),
      token: json["token"],
      name: json["user"]["name"],
      email: json["user"]["email"],
    );
  }
  UserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
  });
}
