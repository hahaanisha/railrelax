import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController carouselController = CarouselController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final appLocalizations = AppLocalizations(context.watch<LanguageProvider>().locale);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(appLocalizations.getText('railrelax')),
        leading: IconButton(
          icon: const Icon(Icons.menu),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(Icons.home, appLocalizations.getText('home'), context, () {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelplinePage()));
            }),
            _buildDrawerItem(Icons.question_answer, appLocalizations.getText('faq'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
            }),
            const Divider(color: Colors.white),
            _buildDrawerItem(Icons.share, appLocalizations.getText('shareWithFriends'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
            }),
            _buildDrawerItem(Icons.contact_phone, appLocalizations.getText('contactUs'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));
            }),
            _buildDrawerItem(Icons.language, appLocalizations.getText('changeLanguage'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
            }),
            _buildDrawerItem(Icons.info, appLocalizations.getText('termsConditions'), context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainPage()));
            }),
            const Divider(color: Colors.white),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.facebook, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Carousel Section without padding
            Container(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
                items: [
                  'assets/homepage_banner.png',
                  'assets/homepage_banner_2.png',
                  'assets/homepage_banner_3.png'
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(
                        i,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            // Dots Indicator
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == i ? Colors.blue : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopBox(context, 'Train Tracking', 'assets/train.png', TrainPage()),
                      _buildTopBox(context, 'Live Chat', 'assets/chat.png', ChatPage()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopBox(context, 'News', 'assets/news.png', NewsPage()),
                      _buildTopBox(context, 'Buy Ticket', 'assets/ticket.png', TicketPage()),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Align(
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
                  const SizedBox(height: 20),
                  _buildGrayBox(context, Icons.help, 'Helpline', HelplinePage()),
                  _buildGrayBox(context, Icons.local_police, 'Police Station Locator', PoliceStationLocatorPage()),
                  _buildGrayBox(context, Icons.question_answer, 'FAQ', FAQPage()),
                  _buildGrayBox(context, Icons.calculate, 'Fare Calculator', FareCalculator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBox(BuildContext context, String title, String imagePath, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
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
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
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

  Widget _buildGrayBox(BuildContext context, IconData icon, String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 30),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
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

  ListTile _buildDrawerItem(IconData icon, String title, BuildContext context, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
