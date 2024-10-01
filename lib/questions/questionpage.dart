import 'package:flutter/material.dart';

class Questionpage extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(int) onOptionSelected;

  const Questionpage({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: options.asMap().entries.map((entry) {
                int idx = entry.key;
                String option = entry.value;
                return ListTile(
                  title: Text(option),
                  leading: Radio(
                    value: idx,
                    groupValue: null,
                    onChanged: (value) {
                      onOptionSelected(value as int);
                    },
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
