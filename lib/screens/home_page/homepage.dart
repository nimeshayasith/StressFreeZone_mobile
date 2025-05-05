import 'package:flutter/material.dart';
import 'package:flutter_application/models/video.dart';
import 'package:flutter_application/screens/todo_list/task.dart';
import 'package:flutter_application/screens/todo_list/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/screens/home_page/content_provider.dart';
import 'package:flutter_application/screens/home_page/todo_provider.dart';
import 'package:flutter_application/screens/todo_list/todo_list_page.dart';
import 'package:flutter_application/services/video_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Video> suggestedVideos = [];
  final VideoService _videoService = VideoService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final videos = await _videoService.fetchVideos();
      setState(() {
        suggestedVideos = videos;
        isLoading = false; // Set loading to false after fetching
      });
    } catch (e) {
      print('Error fetching videos: $e');
      setState(() {
        isLoading = false; // Set loading to false even on error
      });
    }
  }

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

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      Provider.of<ToDoProvider>(context, listen: false)
          .setSelectedDate(pickedDate);
      debugPrint("Selected date: $pickedDate");
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor:
            isDarkMode ? const Color.fromRGBO(59, 94, 132, 1.0) : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => pickDate(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  if (todoProvider.selectedDate != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        getDateMessage(todoProvider.selectedDate),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.yellow : Colors.black,
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  const Text(
                    "Welcome, Charlie",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoListPage()),
                      );
                    },
                    child: const Text('Go to My To-Do List'),
                  ),
                  const SizedBox(height: 20),

                  // Show Suggested Videos from Discover Page
                  buildSectionTitle(context, "Suggested for you"),
                  buildContentList(suggestedVideos),

                  const SizedBox(height: 20),

                  // Show Daily Plan Tasks
                  buildSectionTitle(context, "Daily Plan"),
                  buildTaskList(
                      todoProvider.todoLists
                          .firstWhere(
                            (list) => list.title == 'Daily Plan',
                            orElse: () =>
                                TodoList(title: 'Daily Plan', tasks: []),
                          )
                          .tasks,
                      context),
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

  Widget buildContentList(List<Video> contentList) {
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
                    image: contentList[index].thumbnail,
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

  Widget buildTaskList(List<Task> tasks, BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text('No tasks available in Daily Plan'),
      );
    }

    // Get the index of the Daily Plan list
    final dailyPlanIndex = tasks.isNotEmpty
        ? Provider.of<ToDoProvider>(context)
            .todoLists
            .indexWhere((list) => list.title == 'Daily Plan')
        : -1;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tasks[index].name),
          trailing: Checkbox(
            value: tasks[index].isDone,
            onChanged: (value) {
              // Handle task completion toggle
              if (dailyPlanIndex != -1) {
                Provider.of<ToDoProvider>(context, listen: false)
                    .toggleTaskCompletion(
                        dailyPlanIndex, index as bool, value ?? false);
              }
            },
          ),
        );
      },
    );
  }
}
