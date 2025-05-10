import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';
import 'package:mobile_alumunium/features/domain/repositories/item/item_repository.dart';

class DropdownItemUseCase {
  final ItemRepository repository;
  DropdownItemUseCase(this.repository);
  Future<Either<Failure, List<DropdownItemEntity>>> execute(
      String search, int page) {
    return repository.getDropdownItem(search, page);
  }
}
