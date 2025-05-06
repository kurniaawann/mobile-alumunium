import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';
import 'package:mobile_alumunium/features/presentation/getx/home/home_controller.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/home_body.dart';
import 'package:mobile_alumunium/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = serviceLocator<HomeController>();

  @override
  void initState() {
    homeController.fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {
            TokenStorage.clearUserToken();
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: Obx(() {
        switch (homeController.state) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            final home = homeController.homeData.value;
            return home != null
                ? HomeBody(home: home)
                : const Center(child: Text('No data available'));
          case RequestState.error:
            return Center(child: Text(homeController.message.value));
          case RequestState.empty:
            return const Center(child: Text('No data loaded yet'));
          case RequestState.success: // optional kalau pakai success
            return const Center(child: Text('Operation successful'));
        }
      }),
    );
  }
}
