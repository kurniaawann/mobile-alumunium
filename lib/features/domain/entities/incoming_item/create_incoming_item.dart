import 'package:equatable/equatable.dart';

class CreateIncomingItem extends Equatable {
  final String itemName;
  final int? itemCode;
  final int? width;
  final int? height;
  final int? quantity;
  final bool isFromDropdown; // Tambahkan ini
  final String? id; // Untuk identifikasi item

  const CreateIncomingItem({
    required this.itemName,
    required this.itemCode,
    this.width,
    this.height,
    required this.quantity,
    this.isFromDropdown = false,
    this.id,
  });

  // Copy with method untuk edit
  CreateIncomingItem copyWith({
    String? itemName,
    int? itemCode,
    int? width,
    int? height,
    int? quantity,
    bool? isFromDropdown,
  }) {
    return CreateIncomingItem(
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      width: width ?? this.width,
      height: height ?? this.height,
      quantity: quantity ?? this.quantity,
      isFromDropdown: isFromDropdown ?? this.isFromDropdown,
      id: id, // Pertahankan ID yang sama
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [itemName, itemCode, id];
}
