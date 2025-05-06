import 'package:equatable/equatable.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';

class IncomingItemResponse extends Equatable {
  final String incomingItemsId;
  final String itemId;
  final int quantity;
  final String receivedBy;
  final int priceIncomingItem;
  final DateTime createdAt;
  final DateTime updatedAt;

  const IncomingItemResponse({
    required this.incomingItemsId,
    required this.itemId,
    required this.quantity,
    required this.receivedBy,
    required this.priceIncomingItem,
    required this.createdAt,
    required this.updatedAt,
  });

  IncomingItemEntity toEntity() => IncomingItemEntity(
        incomingItemsId: incomingItemsId,
        itemId: itemId,
        quantity: quantity,
        receivedBy: receivedBy,
        priceIncomingItem: priceIncomingItem,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory IncomingItemResponse.fromJson(Map<String, dynamic> json) {
    return IncomingItemResponse(
      incomingItemsId: json['incoming_items_id'] as String,
      itemId: json['item_id'] as String,
      quantity: json['quantity'] as int,
      receivedBy: json['received_by'] as String,
      priceIncomingItem: json['price_incoming_item'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incoming_items_id': incomingItemsId,
      'item_id': itemId,
      'quantity': quantity,
      'received_by': receivedBy,
      'price_incoming_item': priceIncomingItem,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
        incomingItemsId,
        itemId,
        quantity,
        receivedBy,
        priceIncomingItem,
        createdAt,
        updatedAt,
      ];
}
