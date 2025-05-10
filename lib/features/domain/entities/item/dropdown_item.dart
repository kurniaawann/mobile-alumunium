import 'package:equatable/equatable.dart';

class DropdownItemEntity extends Equatable {
  final String itemName;
  final int? itemCode;
  final int? width;
  final int? height;

  const DropdownItemEntity({
    required this.width,
    required this.height,
    required this.itemName,
    required this.itemCode,
  });

  @override
  List<Object?> get props => [itemName, itemCode, height, width];
}
