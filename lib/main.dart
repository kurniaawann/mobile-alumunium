import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/naavigator_key.dart';
import 'package:mobile_alumunium/common/theme/app_theme.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';
import 'package:mobile_alumunium/routes/page_route.dart';
import 'package:mobile_alumunium/routes/route_name.dart';
import 'package:mobile_alumunium/service_locator.dart';

Future main() async {
  await dotenv.load(fileName: ".env.dev");

  await initDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenStorage.getUserToken(), // Ambil token saat aplikasi mulai
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan loading screen atau splash screen jika token sedang dicek
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          // Jika ada token, arahkan ke halaman utama
          return GetMaterialApp(
            theme: AppTheme.lightTheme,
            getPages: Myroute.pages,
            initialRoute: '/main',
            navigatorKey: navigatorKey,
          );
        } else {
          // Jika tidak ada token, arahkan ke halaman login
          return GetMaterialApp(
            theme: AppTheme.lightTheme,
            getPages: Myroute.pages,
            initialRoute: RouteName.login,
            navigatorKey: navigatorKey,
          );
        }
      },
    );
  }
}
