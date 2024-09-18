import 'dart:io';

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
import 'package:image_picker/image_picker.dart';

class AddStore extends StatefulWidget {
  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  UserModel? userModel;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _expController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _addressController = TextEditingController();
  final _cameraUsedController = TextEditingController();
   bool isLoading = false; // Add loading state

  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
    if (mounted) {
      setState(() {});
    }
  }

   List<File> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _editImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

@override
  void initState() {
    super.initState();
     getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final userModel = Provider.of<AuthProvider>(context).userModel;
    // _emailController.text = userModel.emailConfirmation ?? "";
    // _addressController.text = userModel.address ?? "";
    // _cityController.text = userModel.city ?? "";
    // _companyController.text = userModel.name ?? "";
    // _phoneController.text = userModel.phoneNumber ?? "";
    // _provinceController.text = userModel.phoneNumber ?? "";
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
                label: 'Company Name',
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
                label: 'Experience',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _expController, name: "Experience"),
              SizedBox(
                height: 10,
              ),
                TextLabel(
                label: 'CameraUsed',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _cameraUsedController, name: "CameraUsed"),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                label: 'Country',
              ),
              SizedBox(height: 8),
              TextFormFields(controller: _countryController, name: "Contry"),
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
                SizedBox(
                height: 10,
              ),
                TextLabel(label: 'Add Photo'),
                    SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text('Camera'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF9381FF), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: screenWidth,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/unduh2.png'),
                        SizedBox(height: 3),
                        Text(
                          'Upload your photo',
                          style: TextStyle(
                            color: Color(0xFF9381FF),
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ..._selectedImages.map((image) => Stack(
                      children: [
                        Image.file(File(image!.path)),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF9381FF)),
                            onPressed: () => _deleteImage( _selectedImages.indexOf(image)),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/trash.png'),
                                SizedBox(width: 3),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
               
                SizedBox(height: 50),
              GestureDetector(
                onTap:isLoading
                      ? null
                      : () async  {
                  if (_formKey.currentState!.validate()) {
                     setState(() {
                              isLoading = true; // Set loading to true
                            });
                    print("object2");
                    if (await authProvider.createStore(
                      address: _addressController.text,
                      cameraUsed: _cameraUsedController.text,
                      city: _cityController.text,
                      companyName: _companyController.text,
                      country: _countryController.text,
                      experience: _expController.text,
                      images: _selectedImages,
                      phoneNumber: _phoneController.text,
                      province: _provinceController.text
                      
                    )) {
                      setState(() {});
                     
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileStore()),
                        );
                      
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
