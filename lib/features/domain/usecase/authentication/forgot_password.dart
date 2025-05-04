import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class ForgotPasswordUseCase {
  final AuthenticationRepository repository;
  ForgotPasswordUseCase(this.repository);
  Future<Either<Failure, void>> execute(String newpassword) {
    return repository.forgotPassword(newpassword);
  }
}
