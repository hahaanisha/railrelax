import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/home.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/ticket.dart';
import 'package:railrelax/screens/lib/lang.dart';
import 'package:photo_view/photo_view.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Station Map'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: _buildDrawer(context),
      body: SizedBox.expand(
        child: PhotoView(
          imageProvider: const AssetImage('assets/station_map.jpg'),

          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3.0,
          initialScale: PhotoViewComputedScale.contained,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text('Error loading image: ${error.toString()}'),
              ],
            ),
          ),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }),
          _buildDrawerItem(Icons.train, 'Track Trains', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
          }),
          _buildDrawerItem(Icons.chat, 'Live Chat', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
          }),
          _buildDrawerItem(Icons.map, 'Station Map', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
          }),
          _buildDrawerItem(Icons.notifications, 'News & Alerts', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
          }),
          _buildDrawerItem(Icons.help, 'Helpline', context, () {
            Navigator.pop(context); // Already on this page
          }),
          _buildDrawerItem(Icons.question_answer, 'FAQ', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
          }),
          _buildDrawerItem(Icons.confirmation_number, 'Book Tickets', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage()));
          }),
          Divider(color: Colors.white),
          _buildDrawerItem(Icons.share, 'Share with Friends', context, () {
            Navigator.pop(context);
            // Add share functionality
          }),
          _buildDrawerItem(Icons.contact_phone, 'Contact Us', context, () {
            Navigator.pop(context);
            // Add contact page navigation
          }),
          _buildDrawerItem(Icons.language, 'Change Language', context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
          }),
          _buildDrawerItem(Icons.info, 'Terms & Conditions', context, () {
            Navigator.pop(context);
            // Add terms page navigation
          }),
          Divider(color: Colors.white),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.facebook, color: Colors.white)
              ],
            ),
          ),
          SizedBox(height: 20),
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
}