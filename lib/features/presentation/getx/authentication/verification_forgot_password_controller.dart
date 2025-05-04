import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/verification_forgot_password.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';
import 'package:mobile_alumunium/managers/helper.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class VerificationForgotPasswordController extends GetxController {
  final VerificationForgotPasswordUseCase verificationForgotPasswordUseCase;
  VerificationForgotPasswordController(
      {required this.verificationForgotPasswordUseCase});

  final Rx<RequestState> _state = RequestState.empty.obs;

  RequestState get state => _state.value;

  Future<bool> verificationForgotPassword(
      String email, String codeOtp, BuildContext context) async {
    printErrorDebug('Forgot Password Di Triger');
    _state.value = RequestState.loading;
    final result =
        await verificationForgotPasswordUseCase.execute(email, codeOtp);
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
    }, (data) async {
      _state.value = RequestState.success;
      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Berhasil',
        desc:
            'Berhasil melakukan verifikasi email, silahkan ganti password anda',
        btnOkOnPress: () {
          Get.toNamed(
            RouteName.changePassword,
            arguments: 'forgot_password',
          );
        },
        btnOk: Text(
          'Lanjut',
          style: TextStyle(color: Colors.white),
        ),
      ).show();

      //! Simpan token ke local storage untuk reset password
      await TokenStorage.saveTokenResetPassword(data.accessToken);
      return true;
    });
  }
}
