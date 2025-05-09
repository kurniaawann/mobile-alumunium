import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/features/data/models/incoming_item/incoming_item_model.dart';
import 'package:mobile_alumunium/managers/managers.dart';

abstract class IncomingItemRemoteDataSource {
  Future<List<IncomingItemResponse>> getIncomingItem();
}

class IncomingItemRemoteDataSourceImpl implements IncomingItemRemoteDataSource {
  IncomingItemRemoteDataSourceImpl({required this.httpManager});

  final HttpManager httpManager;

  @override
  Future<List<IncomingItemResponse>> getIncomingItem() async {
    final response = await httpManager.get(url: 'incoming-item/all');

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data ?? [])
          .map(IncomingItemResponse.fromJson)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
