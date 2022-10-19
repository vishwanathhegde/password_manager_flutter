class User {
  final int id;
  final String phone_number;
  final String password;

  User({required this.id, required this.phone_number, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        phone_number: json["phone_number"],
        password: json["password"]);
  }
}
