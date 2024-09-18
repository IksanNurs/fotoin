import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/pages/auth/verify.dart';
import 'package:fotoin/pages/auth/verifyAccount.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        body: RegisterScreen(context));
  }

  Padding RegisterScreen(BuildContext context) {
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
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ),
                ),
                Text(
                  'Register\nAccount',
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
                            if (_formKey.currentState!.validate()) {
                              if (await authProvider.register(
                                  email: _emailController.text,
                                  password: _passController.text)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyAccount(
                                            _emailController.text)));
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
                              }
                            }
                          }
                          setState(() {
                            isLoading = false; // Set loading to true
                          });
                        },
                  child: ButtonGlobal(
                    label: isLoading ? 'Loading...' : 'Register',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an Account? ',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Login',
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
