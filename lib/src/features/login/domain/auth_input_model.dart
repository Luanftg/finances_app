import 'dart:convert';

class AuthInputModel {
  final String email;
  final String password;

  AuthInputModel({required this.email, required this.password});
  factory AuthInputModel.initial() => AuthInputModel(email: '', password: '');

  bool get isValid => this.email.isNotEmpty && this.password.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthInputModel.fromMap(Map<String, dynamic> map) {
    return AuthInputModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthInputModel.fromJson(String source) =>
      AuthInputModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AuthInputModel copyWith({
    String? email,
    String? password,
  }) {
    return AuthInputModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
