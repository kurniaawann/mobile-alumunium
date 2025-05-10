import 'package:equatable/equatable.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';

class DropdownItemResponse extends Equatable {
  final String itemName;
  final int itemCode;

  const DropdownItemResponse({
    required this.itemName,
    required this.itemCode,
  });

  DropdownItemEntity toEntity() {
    return DropdownItemEntity(
      itemName: itemName,
      itemCode: itemCode,
    );
  }

  factory DropdownItemResponse.fromJson(Map<String, dynamic> json) {
    return DropdownItemResponse(
      itemName: json['item_name'] as String,
      itemCode: json['item_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'item_code': itemCode,
    };
  }

  @override
  List<Object?> get props => [itemName, itemCode];
}
