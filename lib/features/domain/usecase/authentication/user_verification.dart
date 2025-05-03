import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/user_verification_request.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class UserVerificationUseCase {
  final AuthenticationRepository repository;
  UserVerificationUseCase(this.repository);
  Future<Either<Failure, void>> execute(
      UserVerificationRequest userVerificationRequest) {
    return repository.userVerification(userVerificationRequest);
  }
}
