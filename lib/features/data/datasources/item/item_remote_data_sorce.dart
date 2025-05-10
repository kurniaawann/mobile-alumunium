import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/features/data/models/item/dropdown_item_model.dart';
import 'package:mobile_alumunium/managers/managers.dart';

abstract class ItemRemoteDataSource {
  Future<List<DropdownItemResponse>> getDataDropdownItem(
      String search, int page);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  ItemRemoteDataSourceImpl({required this.httpManager});
  final HttpManager httpManager;
  @override
  Future<List<DropdownItemResponse>> getDataDropdownItem(
      String search, int page) async {
    final response = await httpManager.get(
        url: 'item/dropdown',
        query: {'search': search, 'page': page.toString()});

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data ?? [])
          .map(DropdownItemResponse.fromJson)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
