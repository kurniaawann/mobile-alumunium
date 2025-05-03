import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/datasources/authentication/authentication_remote_data_soruce.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_model.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/domain/repositories/authentication/authentication_repository.dart';
import 'package:mobile_alumunium/managers/network_info.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthenticationRemoteDataSoruce remoteDataSource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequestModel param) async {
    LoginResponse loginResponse;

    if (await networkInfo.isConnected) {
      try {
        loginResponse = await remoteDataSource.login(param);
        return Right(loginResponse);
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.toString()));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.toString()));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.toString()));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.toString()));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
            NetworkFailure(StringResources.networkFailureMessage));
      } catch (e) {
        return Left(UnknowFailure(e));
      }
    } else {
      return Left(NetworkFailure(StringResources.networkFailureMessage));
    }
  }
}
