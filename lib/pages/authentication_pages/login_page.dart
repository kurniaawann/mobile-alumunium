import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_error.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/pages/authentication_pages/widgets/auth_welcome.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          SvgPicture.asset(
            '${StringResouce.locationImages}/login.svg',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
            icon: Icons.waving_hand,
            title: 'Selamat Datang Kembali!',
            message:
                'Silakan masuk dengan akun Anda untuk mengakses semua fitur aplikasi Alumunium',
          ),

          //Widget error
          CustomError(messageError: 'Email atau password salah'),
          SizedBox(height: 20),

          ///Widget error

          CustomTextfield(
            labelText: 'Email',
            hintText: 'Masukan email',
            iconData: FaIcon(
              FontAwesomeIcons.envelope,
              size: 20,
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            isPassword: true,
            labelText: 'Password',
            hintText: 'Masukan Password',
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
                  Get.toNamed(RouteName.forgotPassword);
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
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Masuk',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
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
          )
        ],
      ),
    );
  }
}
