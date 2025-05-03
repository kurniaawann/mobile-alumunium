import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final String role;

  const LoginResponse({
    required this.accessToken,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "role": role,
      };

  @override
  List<Object?> get props => [accessToken, role];
}
