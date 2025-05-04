import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/utils/custom_default_dialog.dart';
import 'package:mobile_alumunium/features/data/models/authentication/register_request.dart';
import 'package:mobile_alumunium/features/domain/usecase/authentication/register.dart';
import 'package:mobile_alumunium/managers/helper.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class RegisterController extends GetxController {
  final Rx<RequestState> _state = RequestState.empty.obs;

  final RxString _message = ''.obs;
  String get message => _message.value;

  final RegisterUseCase registerUseCase;
  RegisterController({required this.registerUseCase});

  RequestState get state => _state.value;

  void resetErrorMessage() {
    _message.value = '';
    _state.value = RequestState.empty;
  }

  Future<bool> register(
      RegisterRequestModel registerRequestModel, BuildContext context) async {
    _state.value = RequestState.loading;
    final result = await registerUseCase.execute(registerRequestModel);

    return result.fold((failure) {
      _state.value = RequestState.error;
      printErrorDebug(failure.message);

      if (failure.message == 'Email sudah digunakan') {
        _message.value = 'Email sudah digunakan';
      } else if (failure.message == 'No handphone sudah digunakan') {
        _message.value = 'No handphone sudah digunakan';
      }
      return false; // 👈 return false when error
    }, (data) {
      _state.value = RequestState.success;

      CustomDefaultDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Pendaftaran Berhasil! 🎉',
        desc:
            'Kami telah mengirim kode OTP ke email Anda. Silakan verifikasi akun Anda dalam 5 menit untuk mengaktifkan akun.',
        btnOkOnPress: () {
          Get.toNamed(
            RouteName.otp,
            arguments: {
              'email': registerRequestModel.email,
              'type': 'verifikasiEmail'
            },
          );
        },
        btnOk: Text(
          'Verifikasi Sekarang',
          style: TextStyle(color: Colors.white),
        ),
      ).show();
      return true; // 👈 return true when success
    });
  }
}
