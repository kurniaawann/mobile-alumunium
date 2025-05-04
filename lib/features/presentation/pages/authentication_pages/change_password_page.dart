import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/forgot_password_getx.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/service_locator.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  late String? type;

  @override
  void initState() {
    type = Get.arguments as String?;
    debugPrint('Argument yang diterima: $type');
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forgotpasswordController = serviceLocator<ForgotPasswordController>();
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
            '${StringResources.locationImages}/reset_password.png',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
            title: 'Buat Password Baru',
            message: 'Silakan buat password baru yang lebih kuat.',
            icon: Icons.lock_outlined,
          ),
          if (type != 'forgot_password') ...[
            CustomTextfield(
              textEditingController: _oldPasswordController,
              formKey: _formKeys[0],
              isPassword: true,
              labelText: 'Password Lama',
              hintText: 'Masukan password lama',
              iconData: Icon(Icons.lock_outline),
            ),
            SizedBox(height: 30),
          ],
          CustomTextfield(
            textEditingController: _newPasswordController,
            formKey: _formKeys[1],
            isPassword: true,
            labelText: 'Password Baru',
            hintText: 'Masukan password baru',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 30),
          CustomTextfield(
            textEditingController: _confirmPasswordController,
            formKey: _formKeys[2],
            isPassword: true,
            labelText: 'Konfirmasi Password Baru',
            hintText: 'Masukan password baru',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (type == 'forgot_password') {
                forgotpasswordController.forgotPassword(
                    _newPasswordController.text, context);
              }
            },
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
