import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_model.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/data/models/authentication/register_request.dart';
import 'package:mobile_alumunium/features/data/models/authentication/user_verification_request.dart';
import 'package:mobile_alumunium/features/data/models/authentication/verification_forgot_password_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequestModel param);
  Future<Either<Failure, Unit>> register(RegisterRequestModel param);
  Future<Either<Failure, void>> userVerification(UserVerificationRequest param);
  Future<Either<Failure, void>> sendEmailVerification(String email);
  Future<Either<Failure, VerificationForgotPasswordResponse>>
      verificationForgotPassword(String email, String codeOtp);
  Future<Either<Failure, void>> forgotPassword(String newPassword);
}
