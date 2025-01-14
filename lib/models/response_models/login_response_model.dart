
class LoginResponseModel {
    final String? accessToken;
    final String? refreshToken;

    LoginResponseModel({
        this.accessToken,
        this.refreshToken,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}
