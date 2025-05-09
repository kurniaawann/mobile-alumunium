import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';
import 'package:mobile_alumunium/features/domain/usecase/incoming_item/incoming_item.dart';
import 'package:mobile_alumunium/managers/helper.dart';

class IncomingItemController extends GetxController {
  IncomingItemUseCase incomingItemUseCase;

  IncomingItemController({required this.incomingItemUseCase});

  final Rx<RequestState> _state = RequestState.empty.obs;
  late RxString message = ''.obs;
  final incomingItemList = <IncomingItemEntity>[].obs;

  RequestState get state => _state.value;

  Future<void> getDataIncomingItem() async {
    _state.value = RequestState.loading;
    final result = await incomingItemUseCase.execute(); // panggil usecase-nya

    result.fold(
      (failure) {
        printErrorDebug(failure.message);
        printErrorDebug(failure.error);
        _state.value = RequestState.error;
      },
      (data) {
        try {
          incomingItemList.assignAll(data.cast<IncomingItemEntity>());
          _state.value = RequestState.loaded;
        } catch (e) {
          printErrorDebug(e.toString());
          _state.value = RequestState.error;
        }
      },
    );
  }
}
