import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';
import 'package:mobile_alumunium/features/domain/usecase/item/dropdown_item.dart';
import 'package:mobile_alumunium/managers/helper.dart';

class DropdownItemController extends GetxController {
  final DropdownItemUseCase dropdownItemUseCase;

  final Rx<RequestState> _state = RequestState.empty.obs;
  final RxList<DropdownItemEntity> dropdownItemList =
      <DropdownItemEntity>[].obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final Rx<DropdownItemEntity?> selectedItem = Rx<DropdownItemEntity?>(null);

  DropdownItemController({required this.dropdownItemUseCase});

  RequestState get state => _state.value;

  Future<void> getDataDropdownItem(String searchQuery, int page,
      {bool reset = false}) async {
    printErrorDebug(page);
    if (reset) {
      currentPage.value = 1;
      dropdownItemList.clear();
      hasMore.value = true;
    }

    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    _state.value = RequestState.loading;

    final result = await dropdownItemUseCase.execute(searchQuery, page);

    result.fold(
      (failure) {
        message.value = failure.message;
        _state.value = RequestState.error;
        isLoading.value = false;
      },
      (data) {
        if (data.isEmpty) {
          hasMore.value = false;
        } else {
          dropdownItemList.addAll(data);
          currentPage.value++;
        }
        _state.value = RequestState.loaded;
        isLoading.value = false;
      },
    );
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    getDataDropdownItem(query, 1, reset: true);
  }

  void resetState() {
    currentPage.value = 1;
    dropdownItemList.clear();
    searchQuery.value = '';
    hasMore.value = true;
    isLoading.value = false;
    _state.value = RequestState.empty;
  }
}
