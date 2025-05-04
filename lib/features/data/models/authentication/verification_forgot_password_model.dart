import 'package:equatable/equatable.dart';

class VerificationForgotPasswordResponse extends Equatable {
  final String accessToken;

  const VerificationForgotPasswordResponse({
    required this.accessToken,
  });

  factory VerificationForgotPasswordResponse.fromJson(
          Map<String, dynamic> json) =>
      VerificationForgotPasswordResponse(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
      };

  @override
  List<Object?> get props => [
        accessToken,
      ];
}
