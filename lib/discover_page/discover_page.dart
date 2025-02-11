import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'All';
  int _selectedIndex = 1;

  final List<String> categories = [
    'All',
    'Meditation',
    'Movements',
    'Motivation',
    'Soundscape',
    'Learn more'
  ];

  final Map<String, List<Map<String, String>>> categoryData = {
    'Meditation': [
      {'title': 'Cracking Fire', 'time': '45 min', 'status': 'Unguided'},
      {'title': 'Calm Breeze', 'time': '30 min', 'status': 'Unguided'}
    ],
    'Movements': [
      {'title': 'Yoga Flow', 'time': '60 min', 'status': 'Guided'},
    ],
    'Motivation': [
      {'title': 'Morning Boost', 'time': '15 min', 'status': 'Guided'},
    ],
    'Soundscape': [
      {'title': 'Ocean Waves', 'time': '30 min', 'status': 'Unguided'},
      {'title': 'Rainfall', 'time': '20 min', 'status': 'Unguided'}
    ],
    'Learn more': [
      {'title': 'Mindfulness Basics', 'time': '25 min', 'status': 'Guided'}
    ],
    //add more..............................................................
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/discover');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/progress');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedItems = selectedCategory == 'All'
        ? _getAllItemsWithCategoryHeaders()
        : categoryData[selectedCategory]
                ?.map((item) => {'type': selectedCategory, ...item})
                .toList() ??
            [];

    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: displayedItems.isNotEmpty
                ? ListView.builder(
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      var item = displayedItems[index];
                      if (item['isHeader'] == true) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          child: Text(
                            item['type'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/sample_image.jpg'),
                        ),
                        title: Text(item['title'] ?? ''),
                        subtitle: Text('${item['status']} . ${item['time']}'),
                      );
                    },
                  )
                : const Center(
                    child: Text('No items available for this category.'),
                  ),
          ),
        ],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Map<String, dynamic>> _getAllItemsWithCategoryHeaders() {
    List<Map<String, dynamic>> allItems = [];
    categoryData.forEach((category, items) {
      allItems.add({'type': category, 'isHeader': true});
      for (var item in items) {
        allItems.add({'type': category, ...item});
      }
    });
    return allItems;
  }
}
