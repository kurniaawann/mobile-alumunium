import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/data/models/authentication/user_verification_request.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/user_verification.dart';
import 'package:mobile_alumunium/managers/helper.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class UserVerificationController {
  final Rx<RequestState> _state = RequestState.empty.obs;
  final UserVerificationUseCase userVerificationUseCase;

  UserVerificationController({required this.userVerificationUseCase});

  Future<void> userVerificatio(UserVerificationRequest userVerificationRequest,
      BuildContext context) async {
    _state.value = RequestState.loading;
    final result =
        await userVerificationUseCase.execute(userVerificationRequest);
    printErrorDebug(userVerificationRequest.codeOtp);

    return result.fold(
      (failure) {
        _state.value = RequestState.error;
        printErrorDebug(failure.message);

        CustomDefaultDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'terjadi Kesalaham',
          desc: failure.message,
          btnOkOnPress: () {
            Get.back();
          },
          btnOk: Text(
            'Kembali',
            style: TextStyle(color: Colors.white),
          ),
        ).show();
      },
      (data) {
        CustomDefaultDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Berhasil',
          desc: 'Berhasil melakukan verifikasi email, silahkan login',
          btnOkOnPress: () {
            Get.offAllNamed(RouteName.login);
          },
          btnOk: Text(
            'Masuk',
            style: TextStyle(color: Colors.white),
          ),
        ).show();
        _state.value = RequestState.success;
      },
    );
  }
}
