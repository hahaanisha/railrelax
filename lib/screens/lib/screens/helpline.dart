import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/railwayhelpline.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/ticket.dart';
import 'package:railrelax/screens/lib/lang.dart';

class HelplinePage extends StatelessWidget {
  const HelplinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Helpline'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCategoryCard(context, 'Railway Emergency', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Casualty', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Police', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Medical Help', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Blood Bank', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Enquiries', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Women Safety', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Child Helpline', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Senior Citizen Support', RailwayHelplinePage()),
            _buildCategoryCard(context, 'Train Accident Helpline', RailwayHelplinePage()),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', context, () {
            Navigator.pop(context);
            // Add Home navigation action here
          }),
          _buildDrawerItem(Icons.train, 'Track Trains', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
          }),
          _buildDrawerItem(Icons.chat, 'Live Chat', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
          }),
          _buildDrawerItem(Icons.map, 'Station Map', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
          }),
          _buildDrawerItem(Icons.notifications, 'News & Alerts', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
          }),
          _buildDrawerItem(Icons.help, 'Helpline', context, () {
            Navigator.pop(context); // You're already on this page
          }),
          _buildDrawerItem(Icons.question_answer, 'FAQ', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
          }),
          Divider(color: Colors.white),
          _buildDrawerItem(Icons.share, 'Share with Friends', context, () {
            // Placeholder action
          }),
          _buildDrawerItem(Icons.contact_phone, 'Contact Us', context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
          }),
          _buildDrawerItem(Icons.language, 'Change Language', context, () {
            // Placeholder action
          }),
          _buildDrawerItem(Icons.info, 'Terms & Conditions', context, () {
            // Placeholder action
          }),
          Divider(color: Colors.white),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.facebook, color: Colors.white),
                // Add other social media icons if needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, BuildContext context, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}
