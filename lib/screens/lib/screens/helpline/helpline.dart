import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/chat.dart';
import 'package:railrelax/screens/lib/screens/faq.dart';
import 'package:railrelax/screens/lib/screens/helpline/railway_emergencies.dart';
import 'package:railrelax/screens/lib/screens/home.dart';
import 'package:railrelax/screens/lib/screens/railwayhelpline.dart';
import 'package:railrelax/screens/lib/screens/map.dart';
import 'package:railrelax/screens/lib/screens/news.dart';
import 'package:railrelax/screens/lib/screens/train.dart';
import 'package:railrelax/screens/lib/screens/ticket.dart';
import 'package:railrelax/screens/lib/lang.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:railrelax/screens/lib/screens/helpline/hospital_directory.dart';
import 'package:railrelax/screens/lib/screens/helpline/PoliceStationLocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:railrelax/screens/lib/screens/BloodBankPage.dart';

import 'elderlyhelpline.dart';
import 'enquires.dart';

class HelplinePage extends StatelessWidget {
  const HelplinePage({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
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
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            _buildCategoryCard(
              context,
              'Railway Emergency',
              Icons.emergency,
              RailwayEmergenciesPage(),
            ),
            _buildCategoryCard(
              context,
              'Medical Help',
              Icons.local_hospital,
              HospitalDirectoryPage(),
            ),
            _buildCategoryCard(
              context,
              'Police',
              Icons.local_police,
              PoliceStationLocatorPage(),
            ),

            _buildCategoryCard(
                context,
                'Blood Bank',
                Icons.bloodtype,
                null,
                onTap: () async {
                  final url = 'https://mdacs.org.in/pdfs/List%20of%20Blood%20Banks%20in%20Mumbai%20with%20contact%20details.pdf';
                  try {
                    await launcher.launchUrl(
                        Uri.parse(url),
                        mode: launcher.LaunchMode.externalApplication
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not open blood bank list')),
                    );
                  }
                }
            ),
            _buildCategoryCard(
              context,
              'Enquiries',
              Icons.help_outline,
              EnquiriesPage(),
            ),
            _buildCategoryCard(
              context,
              'Women Safety',
              Icons.woman,
              null,
              onTap: () => _makePhoneCall("103"),
            ),

            _buildCategoryCard(
              context,
              'Child Helpline',
              Icons.child_care,
              null,
              onTap: () => _makePhoneCall("1098"),
            ),
            _buildCategoryCard(
              context,
              'Senior Citizen',
              Icons.elderly,
              ElderlyHelplinePage(),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Widget? page, {VoidCallback? onTap}) {
    return InkWell(
    onTap: onTap ?? () {
      if (page != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      }
    },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
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