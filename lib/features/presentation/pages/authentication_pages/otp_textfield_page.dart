import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_leading_appbar.dart';
import 'package:mobile_alumunium/common/widgets/custom_loading.dart';
import 'package:mobile_alumunium/features/data/models/authentication/user_verification_request.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/user_verification_getx.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/verification_forgot_password_controller.dart';
import 'package:mobile_alumunium/routes/route_name.dart';
import 'package:mobile_alumunium/service_locator.dart';

class OtpTextfieldPage extends StatefulWidget {
  const OtpTextfieldPage({super.key});

  @override
  State<OtpTextfieldPage> createState() => _OtpTextfieldPageState();
}

class _OtpTextfieldPageState extends State<OtpTextfieldPage> {
  late String? email;
  late String? type;

  Timer? _timer;
  int _resendCooldown = 60;
  bool _canResend = false;

  @override
  void initState() {
    final args = Get.arguments as Map<String, dynamic>;

    email = args['email'] as String?;
    type = args['type'] as String?;

    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Memulai timer untuk resend cooldown
  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCooldown = 60;
    });

    _timer?.cancel(); // cancel timer sebelumnya (biar gak dobel)
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCooldown > 0) {
          _resendCooldown--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  // Format waktu untuk ditampilkan (mm:ss)
  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Fungsi untuk mengirim ulang kode OTP
  void _resendOtp() {
    if (_canResend) {
      // Implementasikan logika untuk mengirim ulang OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode OTP baru telah dikirim!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Memulai cooldown lagi
      _startResendTimer();
    }
  }

  // Widget untuk bagian Resend OTP di UI
  Widget _buildResendOption() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tidak menerima kode? ",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: _canResend ? _resendOtp : null,
              child: Text(
                "Kirim Ulang",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
            ),
          ],
        ),

        // Menampilkan timer cooldown
        if (!_canResend)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Tunggu ${_formatTime(_resendCooldown)} untuk kirim ulang",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.errorColor,
                  ),
            ),
          ),
      ],
    );
  }

  late String codeOtpSubmit;

  @override
  Widget build(BuildContext context) {
    final userVerificationController =
        serviceLocator<UserVerificationController>();

    final verificationForgotPasswordController =
        serviceLocator<VerificationForgotPasswordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Verifikasi OTP',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: CustomLeadingAppbar(
          onPressed: () => Get.offAllNamed(RouteName.login),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                '${StringResources.locationImages}/otp.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 40),
              Text(
                "Verifikasi Email",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Kami telah mengirimkan kode verifikasi ke nomor Anda. Masukkan kode tersebut di bawah ini.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              LayoutBuilder(builder: (context, constraints) {
                return OtpTextField(
                  numberOfFields: 6,
                  borderColor: const Color(0xFF512DA8),
                  focusedBorderColor: const Color(0xFF512DA8),
                  showFieldAsBox: true,
                  borderWidth: 2.0,
                  fieldWidth: constraints.maxWidth / 7,
                  borderRadius: BorderRadius.circular(12),
                  styles: List.generate(
                    6,
                    (_) => const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onCodeChanged: (String code) {
                    debugPrint(code);
                  },
                  onSubmit: (String verificationCode) {
                    codeOtpSubmit = verificationCode;
                  },
                );
              }),
              const SizedBox(height: 30),
              _buildResendOption(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  if (type == 'forgot-password') {
                    if (verificationForgotPasswordController.state ==
                        RequestState.loading) {
                      return CustomLoading();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        verificationForgotPasswordController
                            .verificationForgotPassword(
                          email ?? 'Email tidak valid',
                          codeOtpSubmit,
                          context,
                        );
                      },
                      child: Text(
                        'Kirim',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    );
                  }

                  if (userVerificationController.state ==
                      RequestState.loading) {
                    return CustomLoading();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      userVerificationController.userVerificatio(
                        UserVerificationRequest(
                          email: email ?? 'Email tidak valid',
                          codeOtp: codeOtpSubmit,
                        ),
                        context,
                      );
                    },
                    child: Text(
                      'Kirim',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
