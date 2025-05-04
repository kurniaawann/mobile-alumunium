import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/forgot_password.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class ForgotPasswordController extends GetxController {
  final Rx<RequestState> _state = RequestState.empty.obs;

  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordController({required this.forgotPasswordUseCase});

  RequestState get state => _state.value;

  Future<bool> forgotPassword(String newPassword, BuildContext context) async {
    _state.value = RequestState.loading;
    final result = await forgotPasswordUseCase.execute(newPassword);
    return result.fold((failure) {
      _state.value = RequestState.error;

      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Terjadi kesalahan',
        desc: failure.message,
        btnOkOnPress: () {
          Get.back();
        },
        btnOk: Text(
          'Tutup',
          style: TextStyle(color: Colors.white),
        ),
      ).show();

      return false;
    }, (success) async {
      TokenStorage.clearTokenResetPassword();
      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Berhasil merubah password',
        desc:
            'Password berhasil diubah, silahkan login menggunakan password baru',
        btnOkOnPress: () {
          Get.offAllNamed(
            RouteName.login,
          );
        },
        btnOk: Text(
          'Verifikasi Sekarang',
          style: TextStyle(color: Colors.white),
        ),
      ).show();
      _state.value = RequestState.success;
      return true;
    });
  }
}
