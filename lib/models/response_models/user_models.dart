// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
    final int? id;
    final String? email;
    final String? password;
    final String? name;
    final String? role;
    final String? avatar;

    UserModel({
        this.id,
        this.email,
        this.password,
        this.name,
        this.role,
        this.avatar,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
    };
}
