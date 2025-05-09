import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';

abstract class IncomingItemRepository {
  Future<Either<Failure, List<IncomingItemEntity>>>
      getIncomingItem(); // Return single entity
}
