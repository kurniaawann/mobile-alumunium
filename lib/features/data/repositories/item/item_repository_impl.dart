import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/data/datasources/item/item_remote_data_sorce.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';
import 'package:mobile_alumunium/features/domain/repositories/item/item_repository.dart';
import 'package:mobile_alumunium/managers/network_info.dart';

class ItemRepositoryImpl implements ItemRepository {
  final NetworkInfo networkInfo;
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DropdownItemEntity>>> getDropdownItem(
      String search, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDataSource.getDataDropdownItem(search, page);
        final List<DropdownItemEntity> entities =
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
