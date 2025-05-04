import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/validators/authentication_validator/send_email_verification_validate.dart';
import 'package:mobile_alumunium/common/widgets/custom_loading.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/send_email_verification_getx.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/service_locator.dart';

class SendEmailVerification extends StatefulWidget {
  const SendEmailVerification({super.key});

  @override
  State<SendEmailVerification> createState() => _SendEmailVerificationState();
}

class _SendEmailVerificationState extends State<SendEmailVerification> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'radenkurni123@gmail.com');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendEmailVerificationController =
        serviceLocator<SendEmailVerificationController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lupa Password',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          Image.asset(
            '${StringResources.locationImages}/forgot_password.png',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
            title: 'Lupa Password?',
            message:
                'Kami akan mengirimkan kode otp untuk mereset password ke email Anda',
            icon: Icons.password_outlined,
          ),
          CustomTextfield(
            textEditingController: _emailController,
            formKey: _formKey,
            validator: (value) => validateEmail(value),
            labelText: 'Email',
            hintText: 'Masukan email',
            iconData: FaIcon(
              FontAwesomeIcons.envelope,
              size: 20,
            ),
          ),
          SizedBox(height: 25),
          Obx(() {
            if (sendEmailVerificationController.state == RequestState.loading) {
              return CustomLoading();
            }
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // final email = _emailController.text;
                  sendEmailVerificationController.sendEmailVerification(
                      _emailController.text, context);
                }
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
        ],
      ),
    );
  }
}
