import 'package:equatable/equatable.dart';

class DropdownItemEntity extends Equatable {
  final String itemName;
  final int itemCode;

  const DropdownItemEntity({
    required this.itemName,
    required this.itemCode,
  });

  @override
  List<Object?> get props => [itemName, itemCode];
}
