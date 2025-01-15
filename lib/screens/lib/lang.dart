import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/helpline/helpline.dart';
import 'package:railrelax/screens/lib/screens/home.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/contact.dart';
import 'package:provider/provider.dart';
import 'package:railrelax/screens/lib/l10n/app_localizations.dart';
import 'package:railrelax/screens/lib/providers/language_provider.dart';
// Import your other screen files here

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final appLocalizations = AppLocalizations(context
        .watch<LanguageProvider>()
        .locale);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(appLocalizations.getText('changeLanguage')),
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
                appLocalizations.getText('menu'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(Icons.home, appLocalizations.getText('home'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage()));
            }),
            _buildDrawerItem(Icons.train, appLocalizations.getText('trackTrains'), context, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrainPage()));
            }),
            _buildDrawerItem(Icons.chat, appLocalizations.getText('liveChat'), context, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            }),
            _buildDrawerItem(Icons.map, appLocalizations.getText('stationMap'), context, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            }),
            _buildDrawerItem(Icons.notifications, appLocalizations.getText('newsAlerts'), context, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewsPage()));
            }),
            _buildDrawerItem(Icons.help, appLocalizations.getText('helpline'), context, () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HelplinePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.question_answer, appLocalizations.getText('faq'), context, () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FAQPage())); // Placeholder
            }),
            Divider(color: Colors.white), // Divider line

            _buildDrawerItem(Icons.share, appLocalizations.getText('shareWithFriends'), context, () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TrainPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.contact_phone, appLocalizations.getText('contactUs'), context, () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ContactUsPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.language, appLocalizations.getText('changeLanguage'), context, () {
              Navigator.pop(context); // Placeholder
            }),
            _buildDrawerItem(Icons.info, appLocalizations.getText('termsConditions'), context, () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TrainPage())); // Placeholder
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
  Text(
  appLocalizations.getText('welcome'),
  style: TextStyle(fontSize: 20),
  ),
  SizedBox(height: 12),
  Text(
  appLocalizations.getText('tagline'),
  style: TextStyle(fontSize: 20),
  ),
  SizedBox(height: 12),
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  _buildLanguageButton(context, 'English', 'en'),
  _buildLanguageButton(context, 'हिंदी', 'hi'),
  _buildLanguageButton(context, 'मराठी', 'mr'),
  ],
  )
  ],
  ),
  );
}
  Widget _buildLanguageButton(BuildContext context, String label, String languageCode) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<LanguageProvider>(context, listen: false)
            .setLocale(languageCode);
      },
      child: Text(label),
    );
  }
  // Top horizontal boxes
  Widget _buildTopBox(BuildContext context, String title, String imagePath, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4, // Width adjusted to screen size
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Vertical gray boxes
  Widget _buildGrayBox(BuildContext context, IconData icon, String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 30),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
}
