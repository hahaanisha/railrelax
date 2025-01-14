import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:railrelax/screens/lib/l10n/app_localizations.dart';
import 'package:railrelax/screens/lib/providers/language_provider.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final String utsScheme = 'com.cris.utsmobile'; // UTS app package name
  final String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.cris.utsmobile';

  @override
  void initState() {
    super.initState();
    _openUTSApp();  // Try to open UTS app automatically when the page is loaded
  }

  Future<void> _openUTSApp() async {
    final utsUri = Uri(scheme: 'utm', host: 'open');  // UTS app URI scheme (confirm this)

    // Check if the UTS app is installed by verifying the intent
    if (await canLaunchUrl(Uri(scheme: 'intent', host: utsScheme))) {
      // Launch UTS app if installed
      await launchUrl(utsUri);
    } else {
      // Redirect to Google Play Store if UTS is not installed
      if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
        await launchUrl(Uri.parse(playStoreUrl));
      } else {
        throw 'Could not launch Play Store URL';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Ticket'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: CircularProgressIndicator(),  // Show a loader while checking for the app
      ),
    );
  }
}
