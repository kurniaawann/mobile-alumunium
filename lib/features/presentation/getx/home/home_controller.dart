import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/domain/usecase/home/home.dart';
import 'package:mobile_alumunium/managers/helper.dart';

class HomeController extends GetxController {
  final HomeUseCase homeUseCase; // ini usecase-nya

  HomeController({required this.homeUseCase});

  final Rx<RequestState> _state = RequestState.empty.obs;
  var message = ''.obs;
  var homeData = Rxn<HomeEntity>();

  RequestState get state => _state.value;

  @override
  void onInit() {
    fetchHomeData();
    printErrorDebug('Dijalankan on inti');
    super.onInit();
  }

  Future<void> fetchHomeData() async {
    _state.value = RequestState.loading;
    final result = await homeUseCase.execute(); // panggil usecase-nya

    result.fold(
      (failure) {
        message.value = failure.message;
        _state.value = RequestState.error;
      },
      (data) {
        homeData.value = data;
        _state.value = RequestState.loaded;
      },
    );
  }
}
