import 'package:equatable/equatable.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';

class DropdownItemResponse extends Equatable {
  final String itemName;
  final int? itemCode;
  final int? width;
  final int? height;

  const DropdownItemResponse({
    required this.width,
    required this.height,
    required this.itemName,
    required this.itemCode,
  });

  DropdownItemEntity toEntity() {
    return DropdownItemEntity(
      itemName: itemName,
      itemCode: itemCode,
      width: width,
      height: height,
    );
  }

  factory DropdownItemResponse.fromJson(Map<String, dynamic> json) {
    return DropdownItemResponse(
      itemName: json['item_name'] as String,
      itemCode: json['item_code'] as int?,
      height: json['height'] as int?,
      width: json['width'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'item_code': itemCode,
      'height': height,
      'width': width,
    };
  }

  @override
  List<Object?> get props => [itemName, itemCode, height, width];
}
