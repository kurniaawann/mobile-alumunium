import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alumunium/common/string_resource/string_resouce.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/validators/authentication_validator/register_validator.dart';
import 'package:mobile_alumunium/common/widgets/custom_error.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/widgets/auth_welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    if (kDebugMode) {
      _nameController.text = 'Kurniawan';
      _emailController.text = 'radenkurni123@gmail.com';
      _phoneController.text = '08123456789';
      _addressController.text = 'Jl. Raya No. 2';
      _passwordController.text = 'Kurni12345.';
      _confirmPasswordController.text = 'Kurni12345.';
    }
    super.initState();
  }

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
            textEditingController: _nameController,
            formKey: _formKeys[0],
            labelText: 'Nama',
            hintText: 'Masukan nama',
            validator: (value) => RegisterValidator.validateFullname(value),
            iconData: Icon(Icons.person_2_outlined),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _emailController,
            formKey: _formKeys[1],
            labelText: 'Email',
            hintText: 'Masukan email',
            validator: (value) => RegisterValidator.validateEmail(value, ''),
            iconData: FaIcon(
              FontAwesomeIcons.envelopeOpen,
              size: 20,
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _phoneController,
            formKey: _formKeys[2],
            labelText: 'No Handphone',
            hintText: 'Masukan nomor handphone',
            iconData: SvgPicture.asset(
              'assets/icons/person.svg',
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _addressController,
            formKey: _formKeys[3],
            labelText: 'Alamat',
            hintText: 'Masukan alamat',
            iconData: Icon(Icons.location_on_outlined),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _passwordController,
            formKey: _formKeys[4],
            isPassword: true,
            labelText: 'Password',
            hintText: 'Masukan password',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            textEditingController: _confirmPasswordController,
            formKey: _formKeys[5],
            isPassword: true,
            labelText: 'Konfirmasi Password',
            hintText: 'Masukan Konfirmasi password',
            iconData: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _formKeys.every((key) => key.currentState!.validate());
            },
            child: Text(
              'Daftar',
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
