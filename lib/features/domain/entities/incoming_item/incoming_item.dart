import 'package:equatable/equatable.dart';

class IncomingItemEntity extends Equatable {
  final String incomingItemsId;
  final String itemId;
  final int quantity;
  final String receivedBy;
  final int priceIncomingItem;
  final DateTime createdAt;
  final DateTime updatedAt;

  const IncomingItemEntity({
    required this.incomingItemsId,
    required this.itemId,
    required this.quantity,
    required this.receivedBy,
    required this.priceIncomingItem,
    required this.createdAt,
    required this.updatedAt,
  });

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
