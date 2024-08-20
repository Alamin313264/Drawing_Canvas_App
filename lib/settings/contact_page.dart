
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

class ContactPage extends HookWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final String email = 'saikha752@gmail.com';

    Future<void> _launchUrl(String url) async {
      if (kIsWeb) {
        html.window.open(
          url,
          url,
        );
      } else {
        if (!await launchUrl(Uri.parse(url))) {
          throw 'Could not launch $url';
        }
      }
    }

    void _launchEmail() async {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: <String, String>{
          'subject': 'Contact from App',
        },
      );
      await launchUrl(emailLaunchUri);
    }
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Color(0xff958d8d),
          title: const Text('Contact Us', style: TextStyle(color: Colors.black87, fontSize: 25,fontWeight: FontWeight.w600),),
        ),
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
            controller: controller,
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(13,5, 13, 5),
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'If you have any questions, suggestions, or feedback, feel free to reach out to us at ',
                  style: TextStyle(fontSize: 16),
                ),
                Row(

                  children: [

                    GestureDetector(
                      onTap: () async {
                        _launchEmail();
                      },
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      '. We’re here to help!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                SizedBox(height: 24),
                Text(
                  'Follow Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stay connected with us for the latest updates, tutorials, and more:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.facebook, color: Colors.blue),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _launchUrl('https://www.facebook.com/profile.php?id=61559885787172');
                      },
                      child: Text(
                        'Alamin Sk',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.linkedin, color: Colors.blue),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                       _launchUrl('https://www.linkedin.com/in/alaminssk/');
                      },
                      child: Text(
                        'Alamin Sk',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.instagram, color: Colors.pink),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _launchUrl('https://www.instagram.com/alaminsk_99/');
                      },
                      child: Text(
                        '@alaminsk_99',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

              ],

        )),




      ),
    );
  }
}
