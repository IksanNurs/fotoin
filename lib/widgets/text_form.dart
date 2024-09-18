import 'package:flutter/material.dart';
import 'package:fotoin/theme.dart';


class TextFormFields extends StatelessWidget {
  const TextFormFields({super.key, required this.controller, this.name});
  final TextEditingController controller;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            cursorColor: primaryColor,
            validator: (value) {
              if(value == null || value.isEmpty)
              {
                return name! + ' Can not be empty';
              }
              if(name=="Email" && (value != null || !value.isEmpty) && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{1,4}$').hasMatch(value)){
                   return 'Email invalid';
              }
              return null;
            } ,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                  fontFamily: 'poppins'
              ),
              // alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(45))
              )
            ),
          )
        ],
      ),
      // controller: controller,
      // keyType: TextInput.keyType,
    );
  }
}