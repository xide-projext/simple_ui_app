import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => ProfileSettingsPageState();
}

class ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController preferencesController = TextEditingController();
  final List<String> preferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Preferences',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: preferencesController,
              decoration: const InputDecoration(
                labelText: 'Add Preference',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  preferences.add(preferencesController.text);
                  preferencesController.clear();
                });
              },
              child: const Text('Save Preference'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: preferences.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(preferences[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          preferences.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

