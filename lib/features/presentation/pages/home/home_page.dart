import 'package:flutter/material.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {
            TokenStorage.clearUserToken();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: const Center(
        child: Text('Welcome to Home Page!'),
      ),
    );
  }
}
