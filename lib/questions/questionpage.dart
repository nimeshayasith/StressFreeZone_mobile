import 'package:flutter/material.dart';

class Questionpage extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(int) onOptionSelected;
  final VoidCallback onNextPressed;

  const Questionpage({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    required this.onNextPressed,
  });

  @override
  _QuestionpageState createState() => _QuestionpageState();
}

class _QuestionpageState extends State<Questionpage> {
  int? _selectedOption;

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
              widget.question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: widget.options.asMap().entries.map((entry) {
                int idx = entry.key;
                String option = entry.value;
                return ListTile(
                  title: Text(option),
                  leading: Radio(
                    value: idx,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value as int;
                        widget.onOptionSelected(_selectedOption!);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOption != null ? widget.onNextPressed : null,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
