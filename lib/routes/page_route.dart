import 'package:get/get.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/change_password_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/otp_textfield_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/register_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/send_email_verification_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/home_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/incoming_item_pages/incoming_item_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/outgoing_item_pages/outgoing_item_page.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class Myroute {
  static final pages = [
    GetPage(name: RouteName.login, page: () => const LoginPage()),
    GetPage(name: RouteName.register, page: () => const RegisterPage()),
    GetPage(
        name: RouteName.sendEmailVerification,
        page: () => const SendEmailVerification()),
    GetPage(
        name: RouteName.sendEmailVerification,
        page: () => const SendEmailVerification()),
    GetPage(name: RouteName.otp, page: () => const OtpTextfieldPage()),
    GetPage(
        name: RouteName.changePassword, page: () => const ChangePasswordPage()),
    GetPage(name: RouteName.homePage, page: () => const HomePage()),
    GetPage(
        name: RouteName.incomingItemPage, page: () => const IncomingItemPage()),
    GetPage(
        name: RouteName.outgoingItemPage, page: () => const OutgoingItemPage()),
  ];
}
