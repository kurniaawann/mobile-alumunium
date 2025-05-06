import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final UserEntity user;
  final List<ItemEntity> item;
  final StatisticsEntity statistics;

  const HomeEntity({
    required this.statistics,
    required this.user,
    required this.item,
  });

  @override
  List<Object> get props => [user, item];
}

class UserEntity extends Equatable {
  final String userName;
  final String address;
  final String noHandphone;

  const UserEntity({
    required this.userName,
    required this.address,
    required this.noHandphone,
  });

  @override
  List<Object> get props => [userName, address, noHandphone];
}

class ItemEntity extends Equatable {
  final String itemId;
  final String itemName;
  final int? itemCode;
  final int stock;
  final int? height;
  final int? width;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ItemEntity({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.stock,
    this.height,
    this.width,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        itemId,
        itemName,
        itemCode,
        stock,
        height,
        width,
        createdAt,
        updatedAt,
      ];
}

class StatisticsEntity extends Equatable {
  final int itemCount;
  final int incomingItemCount;
  final int outgoingItemCount;
  final int projectCount;
  final int lowStockItemsCount;
  final int stockCount;

  const StatisticsEntity({
    required this.itemCount,
    required this.incomingItemCount,
    required this.outgoingItemCount,
    required this.projectCount,
    required this.lowStockItemsCount,
    required this.stockCount,
  });

  @override
  List<Object> get props => [
        itemCount,
        incomingItemCount,
        outgoingItemCount,
        projectCount,
        lowStockItemsCount,
        stockCount
      ];
}
