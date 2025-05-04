import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/validators/authentication_validator/send_email_verification_validate.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/send_email_verification_getx.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/service_locator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'radenkurni78@gmail.com');
    super.initState();
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
          ElevatedButton(
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
          )
        ],
      ),
    );
  }
}
