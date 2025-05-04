import 'package:equatable/equatable.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';

class HomeModel extends Equatable {
  final User user;
  final List<Item> item;

  const HomeModel({
    required this.user,
    required this.item,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      user: User.fromJson(json['user']),
      item: (json['item'] as List)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'item': item.map((e) => e.toJson()).toList(),
    };
  }

  HomeEntity toEntity() {
    return HomeEntity(
      user: UserEntity(
        userName: user.userName,
        address: user.address,
        noHandphone: user.noHandphone,
      ),
      item: item
          .map((e) => ItemEntity(
                itemId: e.itemId,
                itemName: e.itemName,
                itemCode: e.itemCode,
                stock: e.stock,
                height: e.height,
                width: e.width,
                createdAt: e.createdAt,
                updatedAt: e.updatedAt,
              ))
          .toList(),
    );
  }

  @override
  List<Object> get props => [user, item];
}

class User extends Equatable {
  final String userName;
  final String address;
  final String noHandphone;

  const User({
    required this.userName,
    required this.address,
    required this.noHandphone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['user_name'] as String,
      address: json['address'] as String,
      noHandphone: json['no_handphone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'address': address,
      'no_handphone': noHandphone,
    };
  }

  @override
  List<Object> get props => [userName, address, noHandphone];
}

class Item extends Equatable {
  final String itemId;
  final String itemName;
  final int itemCode;
  final int stock;
  final int? height;
  final int? width;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.stock,
    this.height,
    this.width,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['item_id'] as String,
      itemName: json['item_name'] as String,
      itemCode: json['item_code'] as int,
      stock: json['stock'] as int,
      height: json['height'] != null ? json['height'] as int : null,
      width: json['width'] != null ? json['width'] as int : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'item_code': itemCode,
      'stock': stock,
      'height': height,
      'width': width,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

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
