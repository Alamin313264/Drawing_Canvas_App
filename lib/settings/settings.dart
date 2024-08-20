

import 'package:canvas/settings/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'legal_notices.dart';



class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff958d8d),
        title: const Text('Settings', style: TextStyle(color: Colors.black87, fontSize: 25,fontWeight: FontWeight.w600),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: const EdgeInsets.all(5.0),
          children:<Widget> [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LegalNotices(),));
              },
              child: ListTile(
                title: const Text('About & Legal'),
                leading: Icon(Icons.info),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactPage(),));
              },
              child: ListTile(
                title: const Text('Contact Us'),
                leading: Icon(Icons.contact_page),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 6),
             child: ListTile(
                  title: const Text('Version'),
                  subtitle: FutureBuilder(
                      future: getAppVersion(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }else if(!snapshot.hasData) {
                          return Text('Unknown');
                        }else{
                          return Text(snapshot.data ?? 'Unknown');
                        }
                      },),
                ),
           ),


          ],
        ),
      ),

    );
  }
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();



    String version = packageInfo.version;

    return version;
  }
}
