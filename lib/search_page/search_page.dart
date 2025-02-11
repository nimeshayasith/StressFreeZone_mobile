import 'package:flutter/material.dart';
import 'package:flutter_application/search_page/calendar_page.dart';
import 'package:table_calendar/table_calendar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              //..............................................
            },
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Ypur own plan'),
              Tab(text: 'Study'),
              Tab(text: 'Relax'),
              Tab(text: 'Healthy Lifestyle'),
              //add more......................................
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildSearchResultList(),
            buildSearchResultList(),
            buildSearchResultList(),
            buildSearchResultList(),
            //add more....................................................
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: 'Library'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: 1,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                break;
              case 2:
                Navigator.pushNamed(context, '/library');
                break;
              case 3:
                Navigator.pushNamed(context, '/settings');
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildSearchResultList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text("Activity ${index + 1}"),
              subtitle: Text("Details about Activity ${index + 1}"),
            ),
          ),
        );
      },
    );
  }
}
