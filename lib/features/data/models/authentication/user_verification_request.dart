import 'package:equatable/equatable.dart';

class UserVerificationRequest extends Equatable {
  final String email;
  final String codeOtp;

  const UserVerificationRequest({
    required this.email,
    required this.codeOtp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'codeOtp': codeOtp,
    };
  }

  @override
  List<Object> get props => [email, codeOtp];
}
