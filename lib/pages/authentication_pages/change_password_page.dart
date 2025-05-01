import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/pages/authentication_pages/widgets/auth_welcome.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ganti Password',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          Image.asset(
            '${StringResouce.locationImages}/reset_password.png',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
            title: 'Buat Password Baru',
            message: 'Silakan buat password baru yang lebih kuat.',
            icon: Icons.lock_outlined,
          ),
          const CustomTextfield(
            isPassword: true,
            labelText: 'Password Lama',
            hintText: 'Masukan password lama',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 30),
          const CustomTextfield(
            isPassword: true,
            labelText: 'Password Baru',
            hintText: 'Masukan password baru',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 30),
          const CustomTextfield(
            isPassword: true,
            labelText: 'Konfirmasi Password Baru',
            hintText: 'Masukan password baru',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Simpan',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
