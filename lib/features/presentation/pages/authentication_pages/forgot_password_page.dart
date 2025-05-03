import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

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
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            '${StringResouce.locationImages}/forgot_password.png',
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
              Get.toNamed(RouteName.otp);
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
