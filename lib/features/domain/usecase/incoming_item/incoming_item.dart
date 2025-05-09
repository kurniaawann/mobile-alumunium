import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';
import 'package:mobile_alumunium/features/domain/repositories/incoming_Item/incoming_Item_repository.dart';

class IncomingItemUseCase {
  final IncomingItemRepository repository;
  IncomingItemUseCase(this.repository);
  Future<Either<Failure, List<IncomingItemEntity>>> execute() {
    return repository.getIncomingItem();
  }
}
