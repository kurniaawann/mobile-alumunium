import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/validators/authentication_validator/login_validator.dart';
import 'package:mobile_alumunium/common/widgets/custom_loading.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/data/models/authentication/login_request.dart';
import 'package:mobile_alumunium/features/presentation/getx/authentication/login_controller.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/routes/route_name.dart';
import 'package:mobile_alumunium/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'radenkurni123@gmail.com');
    _passwordController = TextEditingController(text: 'Bakur12345.');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = serviceLocator<LoginController>();

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          SvgPicture.asset(
            '${StringResources.locationImages}/login.svg',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
            icon: Icons.waving_hand,
            title: 'Selamat Datang Kembali!',
            message:
                'Silakan masuk dengan akun Anda untuk mengakses semua fitur aplikasi Alumunium',
          ),
          CustomTextfield(
            textEditingController: _emailController,
            formKey: _formKeys[0],
            labelText: 'Email',
            hintText: 'Masukan email',
            validator: (value) => LoginValidator.validateEmail(value),
            iconData: FaIcon(
              FontAwesomeIcons.envelope,
              size: 20,
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _passwordController,
            formKey: _formKeys[1],
            isPassword: true,
            labelText: 'Password',
            hintText: 'Masukan Password',
            validator: (value) => LoginValidator.validatePassword(value),
            iconData: FaIcon(
              FontAwesomeIcons.lock,
              size: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(RouteName.sendEmailVerification,
                      arguments: false);
                },
                child: Text(
                  'Lupa Password?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                ),
              ),
            ],
          ),
          Obx(
            () {
              if (loginController.state == RequestState.loading) {
                return Center(child: CustomLoading());
              }
              return ElevatedButton(
                onPressed: () async {
                  bool allValid =
                      _formKeys.every((key) => key.currentState!.validate());

                  if (allValid) {
                    bool loginValid = await loginController.login(
                      LoginRequestModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                      context,
                    );
                    if (!loginValid) {
                      allValid = _formKeys
                          .every((key) => key.currentState!.validate());
                    }
                  }
                },
                child: Text(
                  'Masuk',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: 5),
              TextButton(
                onPressed: () {
                  Get.toNamed(RouteName.register);
                },
                child: Text(
                  'Daftar sekarang',
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.toNamed(RouteName.sendEmailVerification, arguments: true);
            },
            child: Text(
              'Verifikasi Ulang',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
