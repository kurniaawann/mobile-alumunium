import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/datasources/incoming_item/incoming_item_remote_data_source.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';
import 'package:mobile_alumunium/features/domain/repositories/incoming_Item/incoming_Item_repository.dart';
import 'package:mobile_alumunium/managers/network_info.dart';

class IncomingRepositoryImpl implements IncomingItemRepository {
  final NetworkInfo networkInfo;
  final IncomingItemRemoteDataSource remoteDataSource;

  IncomingRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<IncomingItemEntity>>> getIncomingItem() async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDataSource.getIncomingItem();
        final List<IncomingItemEntity> entities =
            models.map((model) => model.toEntity()).toList();
        return Right(entities); // Return List<Entity>
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
