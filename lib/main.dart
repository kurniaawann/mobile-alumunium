import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_alumunium/common/naavigator_key.dart';
import 'package:mobile_alumunium/common/theme/app_theme.dart';
import 'package:mobile_alumunium/routes/page_route.dart';
import 'package:mobile_alumunium/routes/route_name.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      getPages: Myroute.pages,
      initialRoute: RouteName.login,
      navigatorKey: navigatorKey,
    );
  }
}
