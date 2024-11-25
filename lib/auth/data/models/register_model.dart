// lib/auth/data/models/register_response.dart
class RegisterResponse {
  final String name;
  final String email;
  final String role;
  final List<String> permissions;
  final String id;
  final bool isEmailVerified;

  RegisterResponse({
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
    required this.id,
    required this.isEmailVerified,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      permissions: List<String>.from(json['permissions']),
      id: json['id'],
      isEmailVerified: json['isEmailVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'permissions': permissions,
      'id': id,
      'isEmailVerified': isEmailVerified,
    };
  }
}
