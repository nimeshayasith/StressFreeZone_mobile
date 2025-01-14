import 'package:flutter/material.dart';

class GoalsAndProgramsPage extends StatelessWidget {
  const GoalsAndProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals and Programs'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Set your Goals",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Your Goal',
              hintText: 'e.g., Meditate for 10 mins daily',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Recommended Programs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            title: const Text('Stress Management'),
            subtitle: const Text('Guided programs to relieve stresss'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Better Sleep'),
            subtitle: const Text('Programs to improve sleep quality'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Focus Boosters'),
            subtitle: const Text('Enhance your concentration'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
