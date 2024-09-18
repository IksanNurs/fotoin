import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/profile/profile.dart';
import 'package:fotoin/pages/profile/profile_store.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/session_manager.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/button_global.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;

class AddProfile extends StatefulWidget {
  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  UserModel? userModel;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
   bool isLoading = false; // Add loading state

  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
    if (mounted) {
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final userModel = Provider.of<AuthProvider>(context).userModel;
    _emailController.text = userModel.emailConfirmation ?? "";
    _addressController.text = userModel.address ?? "";
    _cityController.text = userModel.city ?? "";
    _companyController.text = userModel.name ?? "";
    _phoneController.text = userModel.phoneNumber ?? "";
    _provinceController.text = userModel.phoneNumber ?? "";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Store Registration',
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
          // leading: Padding(
          //   padding: const EdgeInsets.only(bottom: 8),
          //   child: Container(
          //     width: 40, // Sesuaikan lebar
          //     height: 40, // Sesuaikan tinggi
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: primaryColor.withOpacity(0.2),
          //     ),
          //     child: IconButton(
          //       icon: Icon(Icons.arrow_back, color: Colors.black),
          //       onPressed: () {
          //       Navigator.pop(context);
          //       },
          //     ),
          //   ),
          // ),
          shadowColor: Color(0x14000000),
          toolbarHeight: 50),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset('assets/user.png'),
                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: primaryColor.withOpacity(0.3),
                    //   ),
                    //   child: Icon(
                    //     Icons.people,
                    //     size: 60,
                    //     color: primaryColor,
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Container(
                    //     width: 12,
                    //     height: 12,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: primaryColor,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.3),
                    //           blurRadius: 4,
                    //           spreadRadius: 1,
                    //         ),
                    //       ],
                    //     ),
                    //     child: IconButton(
                    //       padding: EdgeInsets.zero,
                    //       icon: Icon(Icons.edit, size: 20, color: Colors.white),
                    //       onPressed: () {
                    //         // Aksi ketika tombol ditekan
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  userModel.name ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'User',
                  style: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      userModel.city ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    // Text(
                    //   'Indonesia',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 14,
                    //     fontFamily: 'Inter',
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Email',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _emailController, name: "Email"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Name',
              ),
              SizedBox(height: 8),
              TextFormFields(
                  controller: _companyController, name: "Company Name"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Phone',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _phoneController, name: "Phone"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Province',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _provinceController, name: "Province"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'City',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _cityController, name: "City"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Address',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _addressController, name: "Address"),
              SizedBox(height: 50),
              GestureDetector(
                onTap: isLoading
                      ? null
                      : () async {
                  if (_formKey.currentState!.validate()) {
                         setState(() {
                              isLoading = true; // Set loading to true
                            });
                    print("object2");
                    if (await authProvider.createProfile(
                        email: _emailController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        company_name: _companyController.text,
                        phone_number: _phoneController.text,
                        province: _provinceController.text)) {
                      setState(() {});
                   
                        Navigator.pop(context, true);
                      
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
                 label: isLoading
                        ? 'Loading...'
                        : 'Update', 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
