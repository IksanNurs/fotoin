import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoin/pages/catalogue/catalogue.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final TextEditingController _nominal = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Add loading state
 
 

List<Map<String, String>> categories = [
  {"id": "bca", "name": "BCA"},
  {"id": "mandiri", "name": "MANDIRI"},
  {"id": "bni", "name": "BNI"},
  {"id": "cimb", "name": "CIMB"},
  {"id": "btn", "name": "BTN"},
  {"id": "danamon", "name": "Danamon"},
  {"id": "permata", "name": "Permata"},
  {"id": "bri", "name": "BRI"},
  {"id": "bsi", "name": "BSI"},
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
            'Withdraw Funds',
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel('Nominal'),
                        SizedBox(height: 4),
                        TextFormFields(controller: _nominal, name: "Nominal"),
                        SizedBox(height: 8),
                        TextLabel('Metode Pembayaran'),
                        SizedBox(height: 4),
                        DropDownInput(categories, _selectedValueCategories),
                        SizedBox(height: 8),
                        TextLabel('Nama'),
                        SizedBox(height: 4),
                        TextFormFields(controller: _nama, name: "Nama"),
                        SizedBox(height: 8),
                        TextLabel('No Rekening'),
                        SizedBox(height: 4),
                        TextFormFields(controller: _number, name: "No Rekening"),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0), // Add padding for bottom space
                child: GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true; // Set loading to true
                            });
                            if (await authProvider.postWithdraw(
                              amount: int.parse(_nominal.text),
                              name: _nama.text,
                              number: _number.text,
                              bankname: _selectedValueCategories
                            )) {
                              Navigator.pop(context, true);
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
                            }
                            setState(() {
                              isLoading = false; // Set loading to false
                            });
                          }
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
                        isLoading ? 'Loading...' : 'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
