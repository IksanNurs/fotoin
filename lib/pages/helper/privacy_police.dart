import 'package:flutter/material.dart';
import 'package:fotoin/pages/notification/notificationDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Privacy Policy',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Image.asset('assets/icons/arrow_back.png'),
        ),
        shadowColor: Color(0x14000000),
        toolbarHeight: 50,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Information Collection',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'We collect your personal information when you register on our site, place an order, or fill out a form. Information collected may include your name, email address, mailing address, telephone number, and credit card information.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Use Information',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'We collect several types of information from and about our App users, including:\n'
              '• Personal Information: Your name, email address, phone number, and any other information you voluntarily provide.\n'
              '• Usage Information: Information about how you use the App, including log data, IP address, device type, operating system, and other analytics data.\n'
              '• Location Information: With your permission, we may collect your accurate geographic location information.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'How We Use Your Information',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'We use the information we collect to:\n'
              '• Provide, operate, and maintain the Application.\n'
              '• Understand and analyze how you use the Application.\n'
              '• Develop new products, services, features, and functionality.\n'
              '• Communicate with you, either directly or through one of our partners, including for customer service, providing updates and other information relating to the Application, and for marketing and promotional purposes.\n'
              '• Process transactions and manage your user account.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Disclosure to Third Parties',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'We may disclose your personal information to third parties in the following circumstances:\n'
              '• Service Providers: We may share your information with third-party service providers who assist us in operating the App and conducting our business.\n'
              '• Legal Requirements: We may disclose your information if required by law or in order to comply with legal process.\n'
              '• Security: We may disclose your information if we believe that such disclosure is necessary to protect the rights, property, or safety of FotoIn, our users, or others.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Rights and Choices',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'You have the right to:\n'
              '• Access, update, or delete your personal information.\n'
              '• Object to or restrict the processing of your personal information.\n'
              '• Request a copy of your personal information in a machine-readable format.\n'
              'To exercise these rights, please contact us at officialfotoin@gmail.com.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Contact Us',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at: officialfotoin@gmail.com.',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
