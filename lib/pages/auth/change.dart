import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/auth/email.dart';
import 'package:fotoin/pages/auth/forgot.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/pages/auth/verify.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';

class Change extends StatefulWidget {
  final String email;
  Change(this.email);

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _conpassController = TextEditingController();
  bool obsecurePass = true;
  bool obsecurePass1 = true;
  bool isLoading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: ChangeScreen(context));
  }

  Padding ChangeScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                Text(
                  'Create\nNew Password',
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Your new password must be different from previous used passwords.",
                  style: GoogleFonts.inter(
                      fontSize: 16, color: Colors.grey, fontWeight: regular),
                ),
                SizedBox(height: 24),
                TextLabel(
                  label: 'Password',
                ),
                SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Can not be empty';
                    }
                    return null;
                  },
                  controller: _passController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obsecurePass,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecurePass = !obsecurePass;
                            });
                          },
                          icon: obsecurePass
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black38,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.deepPurple,
                                )),
                      // alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextLabel(
                  label: 'Confirm Password',
                ),
                SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password Can not be empty';
                    }
                    if (value != null &&
                        !value.isEmpty &&
                        _passController.text != value) {
                      return 'Confirm Password not same';
                    }
                    return null;
                  },
                  controller: _conpassController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obsecurePass1,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecurePass1 = !obsecurePass1;
                            });
                          },
                          icon: obsecurePass1
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black38,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.deepPurple,
                                )),
                      // alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)))),
                ),
                SizedBox(height: 8),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true; // Set loading to true
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Verify(
                                        _passController.text, widget.email)));
                            setState(() {
                              isLoading = false; // Set loading to true
                            });
                          }
                        },
                  child: ButtonGlobal(
                    label: isLoading ? "Loading..." : 'Reset Password',
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
