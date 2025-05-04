import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/verification_forgot_password_model.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class VerificationForgotPasswordUseCase {
  final AuthenticationRepository repository;
  VerificationForgotPasswordUseCase(this.repository);
  Future<Either<Failure, VerificationForgotPasswordResponse>> execute(
      String emaiil, String codeOtp) {
    return repository.verificationForgotPassword(emaiil, codeOtp);
  }
}
