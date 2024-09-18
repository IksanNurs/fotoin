import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/payment/paymentpage.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:provider/provider.dart';

class FormBooking extends StatefulWidget {
  final Catalog? catalog;
  const FormBooking({super.key, this.catalog});

  @override
  State<FormBooking> createState() => _FormBookingState();
}

class _FormBookingState extends State<FormBooking> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  bool isLoading = false; // Add loading state
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Reset loading
                      });
                      if (_formKey.currentState!.validate()) {
                        var res = await authProvider.createBooking(
                          address: _address.text,
                          catalogId: widget.catalog?.id ?? "",
                          day: selectedDate.toString(),
                          time: selectedTime.toString(),
                          email: _email.text,
                          name: _name.text,
                          phone: _phone.text,
                        );
                        if (res.item1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Paymentpage(
                                        catalog: widget.catalog,
                                        Name: _name.text,
                                        Phone: _phone.text,
                                        booking_id: res.item2,
                                      )));
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
                    }
                    setState(() {
                      isLoading = false; // Reset loading
                    });
                  },
            child: Container(
                width: screenWidth,
                height: 48,
                decoration: BoxDecoration(
                    color: Color(0xFF9381FF),
                    borderRadius: BorderRadius.circular(32)),
                child: Center(
                    child: Text(
                  isLoading ? 'Loading...' : 'Continue',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: "Inter"),
                ))),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Book Wedding Package',
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
                Text(
                  'Customer Information',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextLabel('Name'),
                SizedBox(
                  height: 4,
                ),
                TextFormFields(controller: _name, name: "Name"),
                SizedBox(
                  height: 8,
                ),
                TextLabel('Email'),
                SizedBox(
                  height: 4,
                ),
                TextFormFields(controller: _email, name: "Email"),
                SizedBox(
                  height: 8,
                ),
                TextLabel('Phone'),
                SizedBox(
                  height: 4,
                ),
                TextFormFields(controller: _phone, name: "Phone"),
                SizedBox(
                  height: 8,
                ),
                TextLabel('Address'),
                SizedBox(
                  height: 4,
                ),
                TextFormFields(controller: _address, name: "Address"),
                SizedBox(
                  height: 8,
                ),
                TextLabel('Time Availabe'),
                SizedBox(
                  height: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Day:',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time:',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${selectedTime.hour}:${selectedTime.minute}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TextLabel(label) {
    return Text(
      label,
      style: TextStyle(
          fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget TextFieldInput(_pcontroller) {
    return TextField(
      controller: _pcontroller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Color(0xFFF8F7FF),
        hoverColor: Colors.amber,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.amberAccent, width: 3)),
      ),
    );
  }
}
