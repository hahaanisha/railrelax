import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/lang.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/helpline/helpline.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/ticket.dart';

import 'helpline/PoliceStationLocator.dart';
import 'contact.dart';
import 'fare_calculator.dart';
import 'package:provider/provider.dart';
import 'package:railrelax/screens/lib/l10n/app_localizations.dart';
import 'package:railrelax/screens/lib/providers/language_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // GlobalKey to control the scaffold state
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final appLocalizations = AppLocalizations(context
        .watch<LanguageProvider>()
        .locale);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(appLocalizations.getText('railrelax')),
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
            _buildDrawerItem(Icons.home, appLocalizations.getText('home'), context,() {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.train, appLocalizations.getText('trackTrains'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
            }),
            _buildDrawerItem(Icons.chat, appLocalizations.getText('liveChat'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
            }),
            _buildDrawerItem(Icons.map, appLocalizations.getText('stationMap'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
            }),
            _buildDrawerItem(Icons.notifications, appLocalizations.getText('newsAlerts'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
            }),
            _buildDrawerItem(Icons.help, appLocalizations.getText('helpline'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelplinePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.question_answer, appLocalizations.getText('faq'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            Divider(color: Colors.white), // Divider line

            _buildDrawerItem(Icons.share, appLocalizations.getText('shareWithFriends'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.contact_phone, appLocalizations.getText('contactUs'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.language, appLocalizations.getText('changeLanguage'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage())); // Placeholder
            }),
            _buildDrawerItem(Icons.info, appLocalizations.getText('termsConditions'), context, () {
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/homepage_banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width / 2 - 194,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
                      },
                      child: Text('Try Now'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the search bar
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        blurRadius: 5, // Spread of the shadow
                        offset: Offset(0, 3), // Position of the shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey), // Hint text style
                      prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
                      border: InputBorder.none, // Removes the default border
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Row for the top 4 boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTopBox(context, 'Train Tracking', 'assets/train.png', TrainPage()),
                  _buildTopBox(context, 'Live Chat', 'assets/chat.png', ChatPage()),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTopBox(context, 'News', 'assets/news.png', NewsPage()),
                  _buildTopBox(context, 'Buy Ticket', 'assets/ticket.png', TicketPage()),
                ],
              ),
              SizedBox(height: 40),
              // 'Other' Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Other',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Vertical boxes
              _buildGrayBox(context, Icons.help, 'Helpline', HelplinePage()),
              _buildGrayBox(context, Icons.local_police, 'Police Station Locator', PoliceStationLocatorPage()),
              _buildGrayBox(context, Icons.question_answer, 'FAQ', FAQPage()),
              _buildGrayBox(context, Icons.calculate, 'Fare Calculator', FareCalculator()),
            ],
          ),
        ),
      ),
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
