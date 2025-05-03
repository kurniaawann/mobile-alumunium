import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_model.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);
  Future<Either<Failure, LoginResponse>> execute(
      LoginRequestModel loginRequestModel) {
    return repository.login(loginRequestModel);
  }
}
