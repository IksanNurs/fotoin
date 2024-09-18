import 'package:flutter/material.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class VerifyAccount extends StatefulWidget {
  final String email;
  VerifyAccount(this.email);

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final _formKey = GlobalKey<FormState>();
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  bool isLoading = false; // Add loading state
  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (index) => TextEditingController());
    _focusNodes = List.generate(4, (index) => FocusNode());
    _initFocusListeners();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _initFocusListeners() {
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus && _otpControllers[i].text.isEmpty) {
          // Clear the input if focused and empty
          _otpControllers[i].clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: VerifyAccountScreen(),
    );
  }

  Widget VerifyAccountScreen() {
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.withOpacity(0.2),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Verify Account Code',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Please enter the code we just sent to email " +
                        widget.email,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a digit';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.length == 1) {
                              // Move focus to the next field if available
                              if (index < _focusNodes.length - 1) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              }
                            } else if (value.isEmpty) {
                              // Move focus to the previous field if deleting
                              if (index > 0) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index - 1]);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
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
                            String otp = _otpControllers
                                .map((controller) => controller.text)
                                .join();
                            print('OTP entered: $otp');
                            if (await authProvider.verifyAccount(
                              email: widget.email,
                              code: int.parse(otp),
                            )) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 2000),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Your account is active. Please login again",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
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
                          setState(() {
                            isLoading = false; // Set loading to true
                          });
                        },
                  child: ButtonGlobal(
                    label: isLoading ? "Loading..." : 'Verify Account',
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
