import 'package:flutter/material.dart';
import '../widgets/spinning_globe.dart';
import 'news_feed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinningGlobe(),
            const SizedBox(height: 20),
            const Text(
              'Smarter, Faster News.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsFeedPage(),
                  ),
                );
              },
              child: const Text('Go to News Feed'),
            ),
          ],
        ),
      ),
    );
  }
}
