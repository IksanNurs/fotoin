import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/catalogue/catalogue.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePortfolio extends StatefulWidget {
  const CreatePortfolio({super.key});

  @override
  State<CreatePortfolio> createState() => _CreatePortfolioState();
}

class _CreatePortfolioState extends State<CreatePortfolio> {
  final TextEditingController _title = TextEditingController();
   final _formKey = GlobalKey<FormState>();
  List<File> _selectedImages = [];
  bool isLoading = false; // Add loading state
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
  List<Map<String, String>> categories = [
    {"id": "1", "name": "Wedding"},
    {"id": "2", "name": "Pre-wedding"},
    {"id": "3", "name": "Birthday"},
    {"id": "4", "name": "Graduation"},
    {"id": "5", "name": "Holiday moments"},
    {"id": "6", "name": "New born"},
    {"id": "7", "name": "Engagement"},
    {"id": "8", "name": "Gender reveal"},
    {"id": "9", "name": "UMKM Photo"},
    {"id": "10", "name": "Family FotoIn"},
    {"id": "11", "name": "Lanskap fotografi"},
    {"id": "12", "name": "Commercial Advertising photo"},
    {"id": "13", "name": "Group photo"},
    {"id": "14", "name": "Lain-lain"},
  ];
  String? _selectedValueCategories;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Add Portfolio',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          toolbarHeight: 50,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/icons/arrow_back.png'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextLabel('Title'),
                SizedBox(height: 4),
                  TextFormFields(controller: _title, name: "Title"),
                SizedBox(height: 8),
                TextLabel('Kategori'),
                SizedBox(height: 4),
               DropDownInput(categories, _selectedValueCategories),
                SizedBox(height: 8),
                TextLabel('Add Photo'),
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: isLoading
                        ? null
                        : () async {
                           if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true; // Set loading to true
                              });
                    if (await authProvider.createPortfolio(
                      categoryId: _selectedValueCategories ?? "",
                      images:_selectedImages,
                      title: _title.text,
                    )) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCatalogue(
                                    tabIndex: 1,
                                  )));
                      // Handle success, e.g., navigate back or show a success message
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
                    }}
                     setState(() {
                                isLoading = false; // Set loading to true
                              });
                  },
                  child: Container(
                    width: screenWidth,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF9381FF),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(
                        isLoading?'Loading...':'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final File? image = await _picker.pickImage(source: source);
  //   if (image != null) {
  //     setState(() {
  //       _selectedImages.add(image);
  //     });
  //   }
  // }

  // void _deleteImage(File? image) {
  //   setState(() {
  //     _selectedImages.remove(image);
  //   });
  // }

  Widget TextLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget TextFieldInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Color(0xFFF8F7FF),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Colors.amberAccent, width: 3),
        ),
      ),
    );
  }

  Widget DropDownInput(
      List<Map<String, String>> options, String? selectedValue) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      value: selectedValue,
      onChanged: (newValue) {
        setState(() {
          _selectedValueCategories = newValue;
        });
      },
      items: options.map<DropdownMenuItem<String>>((option) {
        return DropdownMenuItem(
          value: option["id"],
          child: Text(option["name"]!),
        );
      }).toList(),
    );
  }
}
