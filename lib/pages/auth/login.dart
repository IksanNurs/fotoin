import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/auth/forgot.dart';
import 'package:fotoin/pages/auth/register.dart';
import 'package:fotoin/pages/auth/verifyAccount.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/slide_page.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  bool isLoading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: loginScreen(context));
  }

  Padding loginScreen(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login\nAccount',
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 24),
                TextLabel(
                  label: 'Email',
                ),
                SizedBox(height: 8),
                TextFormFields(controller: _emailController, name: "Email"),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Forgot()));
                      },
                      child: Text(
                        'Forgot the pasword?',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true; // Set loading to true
                            });
                            if (await authProvider.login(
                                email: _emailController.text,
                                password: _passController.text)) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: alertColor,
                                  content: Text(
                                    authProvider.requestModel.message
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              if (authProvider.requestModel.message
                                      .toString() ==
                                  "User is not verified") {
                                Future.delayed(Duration(milliseconds: 1000),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyAccount(
                                            _emailController.text)),
                                  );
                                });
                              }
                            }
                          }
                          setState(() {
                            isLoading = false; // Reset loading
                          });
                        },
                  child: ButtonGlobal(
                    label: isLoading
                        ? 'Loading...'
                        : 'Login', // Pass loading state if needed
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet? ",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: Register()),
                        );
                      },
                      child: Text(
                        ' register',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
