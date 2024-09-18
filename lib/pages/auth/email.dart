import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/auth/change.dart';
import 'package:fotoin/pages/auth/forgot.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/button_outline_global.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Email extends StatefulWidget {
  final String email;
  Email(this.email);
  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _conpassController = TextEditingController();
  bool obsecurePass = true;
  bool obsecurePass1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: EmailScreen(context));
  }

  Padding EmailScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: 40, // Sesuaikan lebar
                  height: 40, // Sesuaikan tinggi
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.2),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // Aksi ketika tombol ditekan
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Forgot()));
                    },
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Check Your Email',
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "We have sent a password recover instruction to your email " +
                      widget.email,
                  style: GoogleFonts.inter(
                      fontSize: 16, color: Colors.grey, fontWeight: regular),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Change(widget.email)));
                },
                child: ButtonGlobal(
                  label: 'Reset Password',
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  try {
                    var url = Uri.parse("https://mail.google.com");

                    await launch(url.toString());
                  } catch (e) {
                    print('Error launching email: $e');
                    // Handle the error with a user-friendly message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                              'Could not launch email application. Please check if an email app is installed.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: ButtonOutlineGlobal(
                  label: 'Open Email App',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
