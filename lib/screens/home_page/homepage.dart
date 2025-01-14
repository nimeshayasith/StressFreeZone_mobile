import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/screens/home_page/content_provider.dart';
import 'package:flutter_application/screens/home_page/todo_provider.dart';
import 'package:flutter_application/screens/todo_list/todo_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final todoProvider = Provider.of<ToDoProvider>(context);

    String getDateMessage(DateTime? date) {
      date ??= DateTime.now();
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final tomorrow = now.add(const Duration(days: 1));

      if (DateUtils.isSameDay(date, now)) {
        return 'Today, \n${DateFormat('EEEE, dd MMMM yyyy').format(date)}';
      } else if (DateUtils.isSameDay(date, yesterday)) {
        return 'Yesterday, \n${DateFormat('EEEE, dd MMMM yyyy').format(date)}';
      } else if (DateUtils.isSameDay(date, tomorrow)) {
        return 'Tomorrow, \n${DateFormat('EEEE, dd MMMM yyyy').format(date)}';
      } else {
        return DateFormat('EEEE, dd MMMM yyyy').format(date);
      }
    }

    Future<void> pickDate(
        BuildContext context, ToDoProvider todoProvider) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        todoProvider.setSelectedDate(pickedDate);
        debugPrint("Selected date: $pickedDate");
      }
      return;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => pickDate(context, todoProvider),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (todoProvider.selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  getDateMessage(todoProvider.selectedDate),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.yellow[300] : Colors.blue[900],
                  ),
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Welcome, Charlie",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodoListPage()),
                );
              },
              child: const Text('Go to My To-Do List'),
            ),
            const SizedBox(
              height: 20,
            ),
            /*buildToDoListSection(context, todoProvider),
            const SizedBox(
              height: 20,
            ),*/
            buildSectionTitle(context, "Suggest for you"),
            buildContentList(contentProvider.suggestedContent),
            const SizedBox(height: 20),
            buildSectionTitle(context, "Trending"),
            buildContentList(contentProvider.trendingContent),
            const SizedBox(height: 20),
            buildSectionTitle(context, "Rain and Storm Sounds"),
            buildContentList(contentProvider.rainAndStormContent),
            const SizedBox(height: 20),
            buildSectionTitle(context, "Explore Meditation Types"),
            buildContentList(contentProvider.meditationTypes),
            const SizedBox(height: 20),
            buildSectionTitle(context, "Breathing Sessions"),
            buildContentList(contentProvider.breathingSessions),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/discover');
              break;
            case 2:
              Navigator.pushNamed(context, '/progress');
              break;
            case 3:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget buildToDoListSection(BuildContext context, ToDoProvider todoProvider) {
    return Column(
      children: [
        Text(
          todoProvider.selectedDate != null
              ? "Today, ${todoProvider.selectedDate!.toLocal()}"
              : "Today",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        todoProvider.tasks.isEmpty
            ? const Center(child: Text('No tasks added yet'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: todoProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = todoProvider.tasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.category),
                    trailing: Checkbox(
                      value: task.isDone,
                      onChanged: (bool? value) {
                        todoProvider.toggleTaskCompletion(index, value!);
                      },
                    ),
                  );
                },
              ),
        ElevatedButton(
          onPressed: () {
            //.........................................................................
            _showAddTaskDialog(context, todoProvider);
          },
          child: const Text('Add Task'),
        ),
      ],
    );
  }

  void _showAddTaskDialog(BuildContext context, ToDoProvider todoProvider) {
    TextEditingController taskNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            controller: taskNameController,
            decoration: const InputDecoration(hintText: 'Task name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                todoProvider.addTask(Task(name: taskNameController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget buildContentList(List<Content> contentList) {
    if (contentList.isEmpty) {
      return const Center(
        child: Text('No content available'),
      );
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: contentList[index].imageUrl,
                    height: 100,
                    width: 150,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/fallback_image.png',
                        height: 100,
                        width: 150,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contentList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contentList[index].duration,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 16),
                          Text(contentList[index].rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
