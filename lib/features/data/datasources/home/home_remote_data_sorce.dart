import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/features/data/models/home/home_model.dart';
import 'package:mobile_alumunium/managers/managers.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required this.httpManager,
  });

  final HttpManager httpManager;
  @override
  Future<HomeModel> getHomeData() async {
    final response = await httpManager.get(url: 'home');
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
