part of '../domain.dart';

class ClientEntity {
  final int id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isAuthenticated;

  ClientEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    this.isAuthenticated = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'phoneNumber': phoneNumber,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory ClientEntity.fromMap(Map<String, dynamic> map) {
    return ClientEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photo_url'] != null ? map['photo_url'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      isAuthenticated: map['isAuthenticated'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientEntity.fromJson(String source) =>
      ClientEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
