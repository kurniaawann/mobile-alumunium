import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
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
      // appBar: AppBar(centerTitle: true, title: Text('Masuk')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          SvgPicture.asset('assets/images/login.svg', width: 300, height: 300),
          CustomTextfield(
            labelText: 'Email',
            hintText: 'Masukan email',
            iconData: SvgPicture.asset('assets/icons/person.svg'),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            isPassword: true,
            labelText: 'Password',
            hintText: 'Masukan Password',
            iconData: SvgPicture.asset('assets/icons/lock.svg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: Text('Lupa Password?'))
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text('Masuk')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Belum punya akun?'),
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
