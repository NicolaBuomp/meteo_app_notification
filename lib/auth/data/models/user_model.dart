// lib/auth/data/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final List<String> permissions;
  final String? profilePictureUrl;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.permissions,
    this.profilePictureUrl,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      permissions: List<String>.from(json['permissions']),
      profilePictureUrl: json['profilePictureUrl'],
      isEmailVerified: json['isEmailVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'permissions': permissions,
      'profilePictureUrl': profilePictureUrl,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
