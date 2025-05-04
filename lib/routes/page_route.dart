import 'package:get/get.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/change_password_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/otp_textfield_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/register_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/authentication_pages/send_email_verification_page.dart';
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

    // GetPage(name: RouteName.homePage, page: () => HomePage()),
    // GetPage(name: RouteName.detailInformasi, page: () => DetailInformasi()),
    // GetPage(name: RouteName.customerReview, page: () => const CustomerReview()),
    // GetPage(name: RouteName.search, page: () => const Search()),
    // GetPage(name: RouteName.favorite, page: () => const Favorite()),
    // GetPage(name: RouteName.setting, page: () => Settings()),
    // GetPage(name: RouteName.addreview, page: () => const Addreview()),
  ];
}
