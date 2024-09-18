import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/auth/email.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/pages/auth/register.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
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
        body:  ForgotScreen(context));
  }

  Padding ForgotScreen(BuildContext context) {
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
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ),
          ),
        
                Text(
                  'Forgot\nAccount',
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                Text(
                "If you need help to resetting your password we can help by sending you a link to reset it.",  
                style: GoogleFonts.inter(
                    fontSize: 16, color: Colors.grey, fontWeight: regular),
             
               
              ),
                SizedBox(height: 24),
                TextLabel(
                  label: 'Email',
                ),
                SizedBox(height: 8),
                TextFormFields(controller: _emailController, name:"Email"),
              SizedBox(height: 50),
                GestureDetector(
                  onTap: isLoading ? null : () async
                      {
                     if (_formKey.currentState!.validate()) {
                              setState(() {
                        isLoading = true; // Set loading to true
                      });
                   if (await authProvider.forgot(
                    email: _emailController.text,
                    )) {
                   Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Email(_emailController.text)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1000),
                      backgroundColor: alertColor,
                      content: Text(
                        authProvider.requestModel.message.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
           
                   
                }

                    }
                        setState(() {
                        isLoading = false; // Set loading to true
                      });
                  },
                  child: ButtonGlobal(
                    label: isLoading?'Loading...' :'Send Instructions',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}