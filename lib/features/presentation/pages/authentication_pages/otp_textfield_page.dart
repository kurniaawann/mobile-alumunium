import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_leading_appbar.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class OtpTextfieldPage extends StatefulWidget {
  const OtpTextfieldPage({super.key});

  @override
  State<OtpTextfieldPage> createState() => _OtpTextfieldPageState();
}

class _OtpTextfieldPageState extends State<OtpTextfieldPage> {
  String? email;

  Timer? _timer;
  int _resendCooldown = 60; // Cooldown awal 60 detik
  bool _canResend = false;
  int _resendAttempts = 0; // Menghitung berapa kali sudah mengirim ulang OTP
  final int _maxResendAttempts =
      3; // Batas maksimal percobaan sebelum cooldown panjang
  final int _extendedCooldown = 300; // Cooldown panjang 5 menit (300 detik)

  @override
  void initState() {
    email = Get.arguments as String?;
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
    // Tentukan durasi cooldown berdasarkan jumlah percobaan
    int cooldownDuration = _resendAttempts >= _maxResendAttempts
        ? _extendedCooldown // 5 menit cooldown setelah 3x percobaan
        : 60; // 60 detik cooldown normal

    setState(() {
      _canResend = false;
      _resendCooldown = cooldownDuration;
    });

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
      // Increment penghitung percobaan kirim ulang
      _resendAttempts++;

      // Di sini implementasikan logika untuk mengirim ulang OTP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_resendAttempts >= _maxResendAttempts
              ? 'Kode OTP baru telah dikirim! Terlalu banyak percobaan, harap tunggu 5 menit untuk percobaan berikutnya.'
              : 'Kode OTP baru telah dikirim! ($_resendAttempts/$_maxResendAttempts)'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
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
                _canResend ? "Kirim Ulang" : "Kirim Ulang",
                // style: TextStyle(
                //   fontSize: 16,
                //   fontWeight: FontWeight.bold,
                //   color: _canResend
                //       ? AppColors.primaryColor
                //       : AppColors.primaryGreyColor,
                // ),
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
              _resendAttempts >= _maxResendAttempts
                  ? "Terlalu banyak percobaan. Tunggu ${_formatTime(_resendCooldown)}"
                  : "Tunggu ${_formatTime(_resendCooldown)} untuk kirim ulang",
              style: _resendAttempts >= _maxResendAttempts
                  ? null
                  : Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.errorColor,
                      ),
            ),
          ),

        // Menampilkan jumlah percobaan
        if (_resendAttempts > 0 && _resendAttempts < _maxResendAttempts)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Percobaan: $_resendAttempts/$_maxResendAttempts",
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
              ),
            ),
          ),
      ],
    );
  }

  void _onOtpVerified() {
    setState(() {
      _resendAttempts = 0; // Reset percobaan jika OTP berhasil diverifikasi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Verifikasi OTP',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: CustomLeadingAppbar(
            onPressed: () => Get.offAllNamed(RouteName.login)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Icon atau Ilustrasi
              Image.asset(
                '${StringResources.locationImages}/otp.png',
                width: 200,
                height: 200,
              ),

              const SizedBox(height: 40),

              // Judul dan petunjuk
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

              // OTP Text Field
              LayoutBuilder(builder: (context, constraints) {
                return OtpTextField(
                  numberOfFields: 6,
                  borderColor: const Color(0xFF512DA8),
                  focusedBorderColor: const Color(0xFF512DA8),
                  showFieldAsBox: true,
                  borderWidth: 2.0,
                  fieldWidth: constraints.maxWidth / 7,
                  borderRadius: BorderRadius.circular(12),
                  styles: const [
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ],
                  onCodeChanged: (String code) {
                    // Logika validasi (opsional)
                  },
                  onSubmit: (String verificationCode) {},
                );
              }),

              const SizedBox(height: 30),

              _buildResendOption(),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.changePassword);
                  },
                  child: Text(
                    'Kirim',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
