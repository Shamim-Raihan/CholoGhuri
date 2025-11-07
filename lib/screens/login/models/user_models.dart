class LoginResponse {
  final bool success;
  final int code;
  final String message;
  final UserModel? data;

  LoginResponse({
    required this.success,
    required this.code,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] == true,
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      data:
          map['data'] != null
              ? UserModel.fromMap(Map<String, dynamic>.from(map['data']))
              : null,
    );
  }
}

class UserModel {
  final String token;
  final String name;
  final String role;

  UserModel({required this.token, required this.name, required this.role});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
    );
  }
}
