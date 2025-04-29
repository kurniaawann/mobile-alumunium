import 'package:get/get.dart';
import 'package:mobile_alumunium/pages/login_page.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

class Myroute {
  static final pages = [
    GetPage(name: RouteName.login, page: () => const LoginPage()),
    // GetPage(name: RouteName.homePage, page: () => HomePage()),
    // GetPage(name: RouteName.detailInformasi, page: () => DetailInformasi()),
    // GetPage(name: RouteName.customerReview, page: () => const CustomerReview()),
    // GetPage(name: RouteName.search, page: () => const Search()),
    // GetPage(name: RouteName.favorite, page: () => const Favorite()),
    // GetPage(name: RouteName.setting, page: () => Settings()),
    // GetPage(name: RouteName.addreview, page: () => const Addreview()),
  ];
}
