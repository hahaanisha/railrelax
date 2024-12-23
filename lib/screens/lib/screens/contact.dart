import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final String myEmail = 'anis191004@gmail.com'; // Replace with your email

  Future<void> _sendEmail() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String message = _messageController.text;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: myEmail,
      query: Uri.encodeFull('subject=Contact Us: $name&body=Email: $email\n\nMessage: $message'),
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendEmail();
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
