import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/login.dart';

class LoginController extends GetxController {
  final Rx<RequestState> _state = RequestState.empty.obs;

  final LoginUseCase loginUseCase;
  LoginController({required this.loginUseCase});

  RequestState get state => _state.value;

  Future<bool> login(LoginRequestModel loginRequestModel) async {
    print('LoginController: logind');
    _state.value = RequestState.loading;
    final result = await loginUseCase.execute(loginRequestModel);
    return result.fold((failure) {
      _state.value = RequestState.error;
      return false;
    }, (data) {
      print('LoginController: login success');
      _state.value = RequestState.loaded;
      return true;
    });
  }
}
