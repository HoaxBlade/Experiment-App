// ignore_for_file: library_private_types_in_public_api, duplicate_ignore

import 'package:flutter/material.dart';
import 'course.dart'; // Import the CoursePage
import 'view_all_screen.dart';
import 'splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashCraft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  bool isInvestment = true;

  final List<NavigationItem> navigationItems = [
    HomeNavigationItem(),
    CoinNavigationItem(),
    MessagesNavigationItem(),
    TransactionHistoryNavigationItem(),
    ProfileNavigationItem(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: navigationItems[currentPageIndex].buildPage(context, this),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navigationItems.map((item) {
              return IconButton(
                icon: Icon(item.icon),
                onPressed: () {
                  setState(() {
                    currentPageIndex = navigationItems.indexOf(item);
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildColoredCard(Color color,
      {double width = 100, double height = 100, String? label}) {
    bool isWideCard = width == double.infinity;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CoursePage()),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: isWideCard
              ? Row(
                  children: [
                    // Image section for wide card
                    Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/200'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Content section for wide card
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    label ?? 'Investment Plan',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      Text(' 4.5',
                                          style: TextStyle(fontSize: 12)),
                                      Text(' • ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text('1,234 enrolled',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹399',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '6 months',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section for regular card
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('https://picsum.photos/200'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Content section for regular card
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label ?? 'Financial Course',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Text(' 4.5',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                Text(
                                  '₹399',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

abstract class NavigationItem {
  IconData get icon;
  // ignore: library_private_types_in_public_api
  Widget buildPage(BuildContext context, _MyHomePageState state);
}

class HomeNavigationItem extends NavigationItem {
  final List<Map<String, String>> recommendedCourses = [
    {
      'title': 'Introduction to Stock Market',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Personal Finance Basics',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Cryptocurrency Trading',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Investment Strategies',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Real Estate Investment',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Retirement Planning',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
  ];

  final List<Map<String, String>> popularCourses = [
    {
      'title': 'Budgeting 101',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Saving Strategies',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Debt Management',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Tax Planning',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Emergency Fund',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
  ];

  @override
  IconData get icon => Icons.home;

  @override
  Widget buildPage(BuildContext context, _MyHomePageState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommended for You",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllScreen(
                          title: 'Recommended Courses',
                          items: recommendedCourses,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Introduction to Stock Market'),
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Personal Finance Basics'),
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Cryptocurrency Trading'),
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Investment Strategies'),
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Real Estate Investment'),
                  state._buildColoredCard(Colors.black,
                      width: 240, label: 'Retirement Planning'),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllScreen(
                          title: 'Popular Courses',
                          items: popularCourses,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Budgeting 101'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Saving Strategies'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Debt Management'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Tax Planning'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Emergency Fund'),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Because you searched "abc"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Mutual Funds'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Bond Investment'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Portfolio Management'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Risk Assessment'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Market Analysis'),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Handpicked just for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 145,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Financial Planning'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Wealth Building'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Estate Planning'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Insurance Basics'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Credit Score'),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Handpicked just for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 145,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Premium Investment Plan'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Gold Investment Plan'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Retirement Fund Plan'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Child Education Plan'),
                  state._buildColoredCard(Colors.black,
                      width: 165, label: 'Tax Saving Plan'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// investment plan and opperunity
class CoinNavigationItem extends NavigationItem {
  final List<Map<String, String>> popularPlans = [
    {
      'title': 'Premium Investment Plan',
      'price': '₹1,999',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Gold Investment Plan',
      'price': '₹1,999',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Retirement Fund Plan',
      'price': '₹1,999',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Child Education Plan',
      'price': '₹1,999',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Tax Saving Plan',
      'price': '₹1,999',
      'image': 'https://picsum.photos/200'
    },
  ];

  final List<Map<String, String>> recommendedPlans = [
    {
      'title': 'Mutual Funds',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Bond Investment',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Portfolio Management',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Risk Assessment',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
    {
      'title': 'Market Analysis',
      'price': '₹399',
      'image': 'https://picsum.photos/200'
    },
  ];

  @override
  IconData get icon => Icons.monetization_on;

  @override
  Widget buildPage(BuildContext context, _MyHomePageState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Plans',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllScreen(
                          title: 'Popular Plans',
                          items: popularPlans,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: <Widget>[
                state._buildColoredCard(Colors.black,
                    width: double.infinity,
                    height: 95,
                    label: 'Premium Investment Plan'),
                const SizedBox(height: 8),
                state._buildColoredCard(Colors.black,
                    width: double.infinity,
                    height: 95,
                    label: 'Gold Investment Plan'),
                const SizedBox(height: 8),
                state._buildColoredCard(Colors.black,
                    width: double.infinity,
                    height: 95,
                    label: 'Retirement Fund Plan'),
                const SizedBox(height: 8),
                state._buildColoredCard(Colors.black,
                    width: double.infinity,
                    height: 95,
                    label: 'Child Education Plan'),
                const SizedBox(height: 8),
                state._buildColoredCard(Colors.black,
                    width: double.infinity,
                    height: 95,
                    label: 'Tax Saving Plan'),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllScreen(
                          title: 'Recommended Plans',
                          items: recommendedPlans,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Investment Strategies'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Real Estate Investment'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Retirement Planning'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Tax Planning'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Emergency Fund'),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recomended for you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Mutual Funds'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Bond Investment'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Portfolio Management'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Risk Assessment'),
                  state._buildColoredCard(Colors.black,
                      width: 150, label: 'Market Analysis'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Chat Page (the only thing left in this entire project is to implement a chatbot and chat function
class MessagesNavigationItem extends NavigationItem {
  @override
  IconData get icon => Icons.message;

  @override
  Widget buildPage(BuildContext context, _MyHomePageState state) {
    final List<Map<String, dynamic>> messages = [
      {'text': 'Hello', 'sender': 'You', 'isMe': true, 'time': '10:00 AM'},
      {'text': 'Hi!', 'sender': 'Alice', 'isMe': false, 'time': '10:01 AM'},
      // Add more messages here
    ];

    final TextEditingController controller = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              final message = messages[index];
              return _buildChatMessage(
                message['text'],
                message['sender'],
                message['isMe'],
                message['time'],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    // Add the new message to the list
                    messages.add({
                      'text': controller.text,
                      'sender': 'You',
                      'isMe': true,
                      'time': 'Now', // You can format the current time here
                    });
                    controller.clear();
                    // Update the UI
                    (context as Element).markNeedsBuild();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatMessage(String text, String sender, bool isMe, String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              child: Text(sender[0]),
            ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  text,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Account Page
class ProfileNavigationItem extends NavigationItem {
  @override
  IconData get icon => Icons.person_rounded;

  @override
  Widget buildPage(BuildContext context, _MyHomePageState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/profile_placeholder.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Account Options
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSection(
                  'Personal Information',
                  [
                    _buildListTile(
                      Icons.person_outline,
                      'Edit Profile',
                      () {
                        // Handle edit profile
                      },
                    ),
                    _buildListTile(
                      Icons.location_on_outlined,
                      'Address',
                      () {
                        // Handle address
                      },
                    ),
                  ],
                ),
                _buildSection(
                  'App Settings',
                  [
                    _buildListTile(
                      Icons.notifications_outlined,
                      'Notifications',
                      () {
                        // Handle notifications
                      },
                    ),
                    _buildListTile(
                      Icons.language_outlined,
                      'Language',
                      () {
                        // Handle language
                      },
                    ),
                    _buildListTile(
                      Icons.dark_mode_outlined,
                      'Theme',
                      () {
                        // Handle theme
                      },
                    ),
                  ],
                ),
                _buildSection(
                  'Support',
                  [
                    _buildListTile(
                      Icons.help_outline,
                      'Help Center',
                      () {
                        // Handle help center
                      },
                    ),
                    _buildListTile(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      () {
                        // Handle privacy policy
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Handle logout
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// Transactin History
class TransactionHistoryNavigationItem extends NavigationItem {
  @override
  IconData get icon => Icons.history;

  @override
  Widget buildPage(BuildContext context, _MyHomePageState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMonthSection('December', '+ ₹150'),
          _buildTransactionItem('John Doe', '19 December', '+ ₹150'),
          const Divider(),
          _buildMonthSection('November', '+ ₹343.50'),
          _buildTransactionItem('Jane Smith', '18 November', '₹40',
              expired: true),
          _buildTransactionItem('John Doe', '11 November', '+ ₹140'),
          _buildTransactionItem('Jane Smith', '3 November', '+ ₹203.50'),
          const Divider(),
          _buildMonthSection('September', '+ ₹634'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹60'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹500'),
          const Divider(),
          _buildMonthSection('August', '+ ₹700'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹60'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹500'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹60'),
          _buildTransactionItem('John Doe', '13 September', '+ ₹500'),
        ],
      ),
    );
  }

  Widget _buildMonthSection(String month, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            month,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            total,
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String name, String date, String amount,
      {bool expired = false}) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      title: Text(name),
      subtitle: Text(date),
      trailing: expired
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  amount,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Request expired',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          : Text(
              amount,
              style: const TextStyle(color: Colors.green),
            ),
    );
  }
}
