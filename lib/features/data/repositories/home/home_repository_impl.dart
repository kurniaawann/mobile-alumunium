import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/datasources/home/home_remote_data_sorce.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/domain/repositories/home/home_repository.dart';
import 'package:mobile_alumunium/managers/network_info.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSorce remoteDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, HomeEntity>> getDataHome() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getHomeData();
        // `result` adalah HomeModel
        return Right(result.toEntity()); // Karena HomeModel EXTENDS HomeEntity
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
