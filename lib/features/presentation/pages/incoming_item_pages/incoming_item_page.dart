import 'package:flutter/material.dart';

class IncomingItemPage extends StatelessWidget {
  const IncomingItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Items')),
      body: const Center(
        child: Text('Incoming Items Page'),
      ),
    );
  }
}
