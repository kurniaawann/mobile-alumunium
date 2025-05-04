import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/verification_forgot_password.dart';
import 'package:mobile_alumunium/managers/helper.dart';

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
      return false;
    }, (data) {
      printErrorDebug(data.accessToken);
      _state.value = RequestState.success;
      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Berhasil',
        desc:
            'Berhasil melakukan verifikasi email, silahkan ganti password anda',
        btnOkOnPress: () {
          // Get.toNamed()
          // Get.offAllNamed(RouteName.login);
        },
        btnOk: Text(
          'Lanjut',
          style: TextStyle(color: Colors.white),
        ),
      ).show();
      return true;
    });
  }
}
