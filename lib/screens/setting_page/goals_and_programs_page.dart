import 'package:flutter/material.dart';

class GoalsAndProgramsPage extends StatefulWidget {
  const GoalsAndProgramsPage({super.key});

  @override
  State<GoalsAndProgramsPage> createState() => _GoalsAndProgramsPageState();
}

class _GoalsAndProgramsPageState extends State<GoalsAndProgramsPage> {
  final List<String> _goals = []; // List to store user goals
  final TextEditingController _goalController = TextEditingController();

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add(_goalController.text);
        _goalController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals and Programs'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set your Goals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _goalController,
                    decoration: const InputDecoration(
                      labelText: 'Your Goal',
                      hintText: 'e.g., Meditate for 10 mins daily',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addGoal,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Your Goals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_goals[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _goals.removeAt(index); // Remove goal on delete
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Recommended Programs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  _buildProgramTile(
                    title: 'Stress Management',
                    description: 'Guided programs to relieve stress.',
                    onTap: () {
                      // Navigate to the program details page
                    },
                  ),
                  _buildProgramTile(
                    title: 'Better Sleep',
                    description: 'Programs to improve sleep quality.',
                    onTap: () {
                      // Navigate to the program details page
                    },
                  ),
                  _buildProgramTile(
                    title: 'Focus Boosters',
                    description: 'Enhance your concentration.',
                    onTap: () {
                      // Navigate to the program details page
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramTile({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
