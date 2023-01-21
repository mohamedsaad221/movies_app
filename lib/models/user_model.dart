class UserModelFields {
  static final List<String> values = [id, name, email, password];

  static const String id = '_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
}

class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;

  UserModel({
     this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json[UserModelFields.id],
        name: json[UserModelFields.name],
        email: json[UserModelFields.email],
        password: json[UserModelFields.password],
      );

  Map<String, dynamic> toJson() => {
        UserModelFields.id: id,
        UserModelFields.name: name,
        UserModelFields.email: email,
        UserModelFields.password: password,
      };
}
