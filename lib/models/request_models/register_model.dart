// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);



class RegisterModel {
    final String? name;
    final String? email;
    final String? password;
    final String? avatar;

    RegisterModel({
        this.name,
        this.email,
        this.password,
        this.avatar,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "avatar": "https://picsum.photos/800",
    };
}
