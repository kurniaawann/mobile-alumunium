import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/widgets/custom_error.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/pages/authentication_pages/widgets/auth_welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Akun',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          Image.asset(
            '${StringResouce.locationImages}/register.png',
            width: 200,
            height: 200,
          ),
          AuthWelcomeCard(
              title: 'Belum punya akun?',
              message:
                  'Daftar dulu di bawah ini untuk mulai menggunakan aplikasi',
              icon: Icons.assignment_outlined),
          CustomError(messageError: 'Email atau password salah'),
          SizedBox(height: 20),
          CustomTextfield(
              labelText: 'Nama',
              hintText: 'Masukan nama',
              iconData: Icon(Icons.person_2_outlined)),
          SizedBox(height: 25),
          CustomTextfield(
            labelText: 'Email',
            hintText: 'Masukan email',
            iconData: FaIcon(
              FontAwesomeIcons.envelopeOpen,
              size: 20,
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            labelText: 'No Handphone',
            hintText: 'Masukan nomor handphone',
            iconData: SvgPicture.asset(
              'assets/icons/person.svg',
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            labelText: 'Alamat',
            hintText: 'Masukan alamat',
            iconData: Icon(Icons.location_on_outlined),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            isPassword: true,
            labelText: 'Password',
            hintText: 'Masukan password',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            isPassword: true,
            labelText: 'Konfirmasi Password',
            hintText: 'Masukan Konfirmasi password',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 25),
          ElevatedButton(onPressed: () {}, child: Text('Daftar')),
        ],
      ),
    );
  }
}
