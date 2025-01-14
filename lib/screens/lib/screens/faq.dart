import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/lang.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/helpline/helpline.dart';
import 'package:railrelax/screens/lib/screens/home.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'contact.dart';
import 'package:provider/provider.dart';
import 'package:railrelax/screens/lib/l10n/app_localizations.dart';
import 'package:railrelax/screens/lib/providers/language_provider.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GlobalKey to control the scaffold state
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('RailRelax FAQ'),
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
            _buildDrawerItem(Icons.home, 'Home', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }),
            _buildDrawerItem(Icons.train, 'Track Trains', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Navigate to relevant page
            }),
            _buildDrawerItem(Icons.chat, 'Live Chat', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.map, 'Station Map', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.notifications, 'News & Alerts', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.help, 'Helpline', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelplinePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.question_answer, 'FAQ', context, () {
              Navigator.pop(context); // Close the drawer, we are already on the FAQ page
            }),
            Divider(color: Colors.white),
            _buildDrawerItem(Icons.share, 'Share with Friends', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.contact_phone, 'Contact Us', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.language, 'Change Language', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.info, 'Terms & Conditions', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Placeholder
            }),
            Divider(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image below the app bar
            Center(
              child: Image.asset('assets/faq.png', width: 200, height: 150),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),

                  // FAQ Accordion
                  _buildFAQItem('What is RailRelax?', 'Railrelax is a train tracking app that uses the real-time video of the surveillance of the video cameras that are placed in each compartment of the train. This app will help the passengers to place themselves on the station according to the compartment in which they either want the space to sit or the space to stand.'),
                  _buildFAQItem('How can I track my train?', 'There is an option to track trains on the home page. By clicking on the option you will be redirected to a new page which provides a list of trains that will tell which train is their at which station and how late that train is.'),
                  _buildFAQItem('Is there a live chat available?', 'There is a chatbot that is available on the home page when the app is opened.'),
                  _buildFAQItem('How do I change the language?', 'At the top left side of the page press on the button with 3 lines. When you press on it a language option will be available, press on it and it will redirect you to language page.'),
                  _buildFAQItem('Can I access the news and alerts?', 'Yes, you can access the news and alerts by pressing the news option that is available on the home page of the railrelax app.'),
                  _buildFAQItem('How to contact customer support?', 'In hte menu option at the top right corner, the ContactUs option is available. By pressing that button you will redirected to the ContactUs page.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer item builder
  ListTile _buildDrawerItem(IconData icon, String title, BuildContext context, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  // Build FAQ Accordion Item
  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
