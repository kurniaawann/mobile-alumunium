import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_model.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/managers/managers.dart';

abstract class AuthenticationRemoteDataSoruce {
  Future<LoginResponse> login(LoginRequestModel loginRequestModel);
}

class AuthenticationRemoteDataSoruceImpl
    implements AuthenticationRemoteDataSoruce {
  AuthenticationRemoteDataSoruceImpl({
    required this.httpManager,
  });

  final HttpManager httpManager;
  @override
  Future<LoginResponse> login(LoginRequestModel loginRequestModel) async {
    (loginRequestModel.toJson());
    final response = await httpManager.post(url: 'authentication/login', data: {
      "email": loginRequestModel.email,
      "password": loginRequestModel.password,
    });
    (response.data);
    (response.statusCode);
    if (response.statusCode == 200) {
      (response.data);
      return LoginResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
