import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LegalNotices extends HookWidget {
  const LegalNotices({super.key});

  @override
  Widget build(BuildContext context) {

    final scrollController = useScrollController();
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xff958d8d),
        title: const Text('About & Legal', style: TextStyle(color: Colors.black87, fontSize: 25,fontWeight: FontWeight.w600),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(13,5, 13, 5),
              controller:scrollController,
              children: [
                const SizedBox(height: 10),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2,
                    wordSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 9,),
                Text(
                  'Drawing Canvas',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                const SizedBox(height: 9,),
                const Text('Welcome to Drawing Canvas! Our mission is to provide you with a seamless drawing experience that empowers creativity and artistic expression. Whether you’re a professional artist or just starting, Drawing Canvas offers the tools you need to create stunning digital art and explore your artistic potential.',style: TextStyle(fontSize: 16),),
                const SizedBox(height: 10,),
                const Text('At Drawing Canvas, we believe in continuous innovation and user-centered design. Our team is dedicated to enhancing your experience with regular updates, new features, and top-notch customer support. Thank you for choosing us as your creative companion!', style: TextStyle(fontSize: 16),),

                const SizedBox(height: 12,),
                Divider(color: Colors.grey.shade500,thickness: 1,),
                const SizedBox(height: 12,),
                Text('Legal', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,),),
                SizedBox(height: 8.0),
                Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),),
                SizedBox(height: 8.0),

                Text(
                'By using Drawing Canvas, you agree to comply with and be bound by the following terms and conditions. These terms govern your access to and use of the app, including any content, functionality, and services offered. If you do not agree with any part of these terms, please discontinue use of the app.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
                SizedBox(height: 16.0),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Your privacy is important to us. Our Privacy Policy outlines the types of information we collect, how we use it, and the measures we take to protect your data. We are committed to safeguarding your privacy and ensuring that your personal information is secure.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),

                SizedBox(height: 16.0),
                Text(
                  'Intellectual Property',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'All content, features, and functionality available within Drawing Canvas (including but not limited to text, graphics, logos, icons, images, and software) are the exclusive property of Alamin Sk and are protected by international copyright, trademark, patent, and other intellectual property laws.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'User Content',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'You retain ownership of any content you create within Drawing Canvas. However, by submitting content, you grant us a non-exclusive, royalty-free, worldwide license to use, reproduce, modify, and distribute your content solely for the purpose of operating, promoting, and improving the app.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Limitation of Liability',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'To the fullest extent permitted by law, Alamin Sk shall not be liable for any direct, indirect, incidental, special, or consequential damages resulting from the use or inability to use the app, even if Alamin Sk has been advised of the possibility of such damages.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Changes to This Agreement',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'We may update our Terms of Service and Privacy Policy from time to time. We will notify you of any changes by updating the date at the top of these documents. Continued use of the app after any such changes shall constitute your consent to those changes.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'If you have any legal inquiries, please contact us at saikha752@gmail.com.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),

            ],

            ),
        ),
      ),
    );
  }
}
