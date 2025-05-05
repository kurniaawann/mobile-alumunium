import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_alumunium/features/data/datasources/authentication/authentication_remote_data_soruce.dart';
import 'package:mobile_alumunium/features/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/forgot_password.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/login.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/register.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/send_email_verification.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/user_verification.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/verification_forgot_password.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/forgot_password_controller.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/login_controller.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/register_controller.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/send_email_verification_controller.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/user_verification_controller.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/verification_forgot_password_controller.dart';
import 'package:mobile_alumunium/managers/dio_loging_inceptors.dart';
import 'package:mobile_alumunium/managers/managers.dart';
import 'package:mobile_alumunium/managers/network_info.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencyInjection() async {
  // Register Durations dengan nama berbeda
  serviceLocator.registerLazySingleton<Duration>(
    () => const Duration(seconds: 15),
    instanceName: 'timeout',
  );
  serviceLocator.registerLazySingleton<Duration>(
    () => const Duration(seconds: 60),
    instanceName: 'uploadTimeout',
  );

  serviceLocator
      .registerLazySingleton<SimpleInterceptor>(() => SimpleInterceptor());

  serviceLocator.registerLazySingleton<HttpManager>(
    () => AppHttpManager(
      serviceLocator<SimpleInterceptor>(),
      serviceLocator<Duration>(instanceName: 'timeout'),
      serviceLocator<Duration>(instanceName: 'uploadTimeout'),
    ),
  );

  serviceLocator.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator<InternetConnectionChecker>()),
  );

  //! Data Sources
  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSoruce>(
    () => AuthenticationRemoteDataSoruceImpl(
      httpManager: serviceLocator(),
    ),
  );

  //! Repository
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
            remoteDataSource: serviceLocator(),
            networkInfo: serviceLocator(),
          ));

  //! use cases
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => RegisterUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UserVerificationUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SendEmailVerification(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => VerificationForgotPasswordUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ForgotPasswordUseCase(
      serviceLocator(),
    ),
  );

  //! Controllers
  serviceLocator.registerLazySingleton(
    () => LoginController(loginUseCase: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => RegisterController(registerUseCase: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UserVerificationController(userVerificationUseCase: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => SendEmailVerificationController(
        sendEmailVerificationUseCase: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => VerificationForgotPasswordController(
        verificationForgotPasswordUseCase: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => ForgotPasswordController(forgotPasswordUseCase: serviceLocator()),
  );
}
