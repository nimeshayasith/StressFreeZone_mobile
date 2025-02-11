import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';

class Questionpage extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(int) onOptionSelected;
  final VoidCallback onNextPressed;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Questionpage({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QuestionpageState createState() => _QuestionpageState();
}

class _QuestionpageState extends State<Questionpage> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Question"),
        backgroundColor:
           themeProvider.isDarkMode ? const Color.fromRGBO(59, 94, 132, 1.0) : const Color.fromARGB(255, 15, 206, 240),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor:
          themeProvider.isDarkMode ? const Color.fromRGBO(59, 94, 132, 1.0) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: widget.options.asMap().entries.map((entry) {
                int idx = entry.key;
                String option = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = idx;
                      widget.onOptionSelected(_selectedOption!);
                    });
                  },
                  child: ListTile(
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
