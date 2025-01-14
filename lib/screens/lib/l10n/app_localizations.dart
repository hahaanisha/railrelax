import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'railrelax': 'RailRelax',
      'welcome': 'Welcome to Railrelax',
      'tagline': 'Enhancing train travel comfort',
      'changeLanguage': 'Change Language',
      'menu': 'Menu',
      'home': 'Home',
      'trackTrains': 'Track Trains',
      'liveChat': 'Live Chat',
      'stationMap': 'Station Map',
      'newsAlerts': 'News & Alerts',
      'helpline': 'Helpline',
      'faq': 'FAQ',
      'shareWithFriends': 'Share with Friends',
      'contactUs': 'Contact Us',
      'termsConditions': 'Terms & Conditions'
    },
    'hi': {
      'railrelax': 'रेलरिलैक्स',
      'welcome': 'रेलरिलैक्स में आपका स्वागत है',
      'tagline': 'ट्रेन यात्रा आराम बढ़ाना',
      'changeLanguage': 'भाषा बदलें',
      'menu': 'मेन्यू',
      'home': 'होम',
      'trackTrains': 'ट्रेन ट्रैक करें',
      'liveChat': 'लाइव चैट',
      'stationMap': 'स्टेशन मैप',
      'newsAlerts': 'समाचार और अलर्ट',
      'helpline': 'हेल्पलाइन',
      'faq': 'सामान्य प्रश्न',
      'shareWithFriends': 'दोस्तों के साथ शेयर करें',
      'contactUs': 'संपर्क करें',
      'termsConditions': 'नियम और शर्तें'
    },
    'mr': {
      'railrelax': 'रेल्वे आराम',
      'welcome': 'रेलरिलॅक्स मध्ये आपले स्वागत आहे',
      'tagline': 'ट्रेन प्रवास आराम वाढवणे',
      'changeLanguage': 'भाषा बदला',
      'menu': 'मेनू',
      'home': 'होम',
      'trackTrains': 'ट्रेन ट्रॅक करा',
      'liveChat': 'लाइव्ह चॅट',
      'stationMap': 'स्टेशन नकाशा',
      'newsAlerts': 'बातम्या आणि सूचना',
      'helpline': 'हेल्पलाइन',
      'faq': 'सामान्य प्रश्न',
      'shareWithFriends': 'मित्रांसोबत शेअर करा',
      'contactUs': 'संपर्क करा',
      'termsConditions': 'नियम आणि अटी'
    }
  };

  String getText(String key) => _localizedValues[locale.languageCode]?[key] ?? '';
}