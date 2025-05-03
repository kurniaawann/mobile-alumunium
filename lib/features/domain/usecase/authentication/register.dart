import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/register_request.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class RegisterUseCase {
  final AuthenticationRepository repository;
  RegisterUseCase(this.repository);
  Future<Either<Failure, void>> execute(
      RegisterRequestModel registerRequestModel) {
    return repository.register(registerRequestModel);
  }
}
