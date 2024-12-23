import 'package:flutter/material.dart';

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
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.train, 'Track Trains', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Navigate to relevant page
            }),
            _buildDrawerItem(Icons.chat, 'Live Chat', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.map, 'Station Map', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.notifications, 'News & Alerts', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.help, 'Helpline', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.question_answer, 'FAQ', context, () {
              Navigator.pop(context); // Close the drawer, we are already on the FAQ page
            }),
            Divider(color: Colors.white),
            _buildDrawerItem(Icons.share, 'Share with Friends', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.contact_phone, 'Contact Us', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.language, 'Change Language', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
            }),
            _buildDrawerItem(Icons.info, 'Terms & Conditions', context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage())); // Placeholder
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
                  _buildFAQItem('What is RailRelax?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  _buildFAQItem('How can I track my train?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  _buildFAQItem('Is there a live chat available?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  _buildFAQItem('How do I change the language?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  _buildFAQItem('Can I access the news and alerts?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  _buildFAQItem('How to contact customer support?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
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
