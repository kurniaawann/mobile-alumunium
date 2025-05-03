import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_model.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/data/models/authentication/register_request.dart';
import 'package:mobile_alumunium/features/data/models/authentication/user_verification_request.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequestModel param);
  Future<Either<Failure, Unit>> register(RegisterRequestModel param);
  Future<Either<Failure, void>> userVerification(UserVerificationRequest param);
}
