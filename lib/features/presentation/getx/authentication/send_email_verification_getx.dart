import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/send_email_verification.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class SendEmailVerificationController extends GetxController {
  final Rx<RequestState> _state = RequestState.empty.obs;

  final SendEmailVerification sendEmailVerificationUseCase;
  SendEmailVerificationController({required this.sendEmailVerificationUseCase});

  RequestState get state => _state.value;

  Future<bool> sendEmailVerification(String email, BuildContext context) async {
    _state.value = RequestState.loading;
    final result = await sendEmailVerificationUseCase.execute(email);
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
    }, (success) {
      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Kode verifikasi dikirim ke',
        desc:
            'Kami telah mengirim kode OTP ke email anda, silahkan cek email anda untuk melanjutkan proses verifikasi',
        btnOkOnPress: () {
          Get.toNamed(
            RouteName.otp,
            arguments: {'email': email, 'type': 'forgot-password'},
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
