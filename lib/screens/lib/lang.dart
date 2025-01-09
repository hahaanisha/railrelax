import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/helpline.dart';
import 'package:railrelax/screens/lib/screens/home.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/contact.dart';


class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Change Language'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
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
            _buildDrawerItem(Icons.home, 'Home', context,() {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelplinePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.question_answer, 'FAQ', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            Divider(color: Colors.white), // Divider line

            _buildDrawerItem(Icons.share, 'Share with Friends', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.contact_phone, 'Contact Us', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.language, 'Change Language', context, () {
              Navigator.push(context); // Placeholder
            }),
            _buildDrawerItem(Icons.info, 'Terms & Conditions', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Placeholder
            }),

            Divider(color: Colors.white), // Divider line

            // Social Media Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.facebook, color: Colors.white),
                  // Icon(Icons.twitter, color: Colors.white),
                  // Icon(Icons.instagram, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to Railrelax',style: TextStyle(fontSize: 20),),
          SizedBox(height: 12,),
          Text('Railrelax - Enhancing train travel comfort',style: TextStyle(fontSize: 20),),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){}, child: Text('English')),
              ElevatedButton(onPressed: (){}, child: Text('Hindi')),
              ElevatedButton(onPressed: (){}, child: Text('Marathi')),
            ],
          )
        ],
      ),
    );
  }
}