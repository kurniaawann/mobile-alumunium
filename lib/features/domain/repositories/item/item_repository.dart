import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<DropdownItemEntity>>> getDropdownItem(
      String search, int page);
}
