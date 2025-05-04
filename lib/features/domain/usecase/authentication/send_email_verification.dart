import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class SendEmailVerification {
  final AuthenticationRepository repository;
  SendEmailVerification(this.repository);
  Future<Either<Failure, void>> execute(String email) {
    return repository.sendEmailVerification(email);
  }
}
