import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoin/model/protofolio.dart';
import 'package:fotoin/pages/catalogue/catalogue.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/text_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateCatalogue1 extends StatefulWidget {
  const CreateCatalogue1({super.key});

  @override
  State<CreateCatalogue1> createState() => _CreateCatalogue1State();
}

class _CreateCatalogue1State extends State<CreateCatalogue1> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _location = TextEditingController();
  bool isLoading = false; // Add loading state
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();
  TimeOfDay? selectedStartTime = TimeOfDay.now();
  TimeOfDay? selectedEndTime = TimeOfDay.now();
  List<File> _images = [];

  getProtofolio() async {
    await Provider.of<AuthProvider>(context, listen: false).getProtofolio();
    if (mounted) {
      setState(() {});
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _editImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    // Pilih tanggal mulai
    final DateTime? startDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (startDate != null && startDate != selectedStartDate) {
      // Pilih tanggal akhir
      final DateTime? endDate = await showDatePicker(
        context: context,
        initialDate: selectedEndDate ?? startDate.add(Duration(days: 1)),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (endDate != null && endDate != selectedEndDate) {
        setState(() {
          selectedStartDate = startDate;
          selectedEndDate = endDate;
        });
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    // Pilih waktu mulai
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (startTime != null && startTime != selectedStartTime) {
      // Pilih waktu akhir
      final TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: selectedEndTime ??
            _addHour(
                startTime, 1), // Misalnya waktu akhir 1 jam setelah waktu mulai
      );

      if (endTime != null && endTime != selectedEndTime) {
        setState(() {
          selectedStartTime = startTime;
          selectedEndTime = endTime;
        });
      }
    }
  }

// Helper function to add hours to a TimeOfDay
  TimeOfDay _addHour(TimeOfDay time, int hours) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final newDateTime = dateTime.add(Duration(hours: hours));
    return TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
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
  String? _selectedValueProtofolio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProtofolio();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final protofolioModel = Provider.of<AuthProvider>(context).protofolio;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Add Catalog',
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextLabel('Catalog Name'),
                SizedBox(height: 4),
                TextFormFields(controller: _name, name: "Name"),
                SizedBox(height: 8),
                TextLabel('Categories'),
                SizedBox(height: 4),
                DropDownInput(categories, _selectedValueCategories),
                SizedBox(height: 8),
                TextLabel('Protofolio'),
                SizedBox(height: 4),
                DropDownInputProtofolio(
                    protofolioModel, _selectedValueProtofolio),
                SizedBox(height: 8),
                TextLabel('Description'),
                SizedBox(height: 4),
                TextFormFields(controller: _desc, name: "Description"),
                SizedBox(height: 8),
                TextLabel('Fee'),
                SizedBox(height: 4),
                TextFormFields(controller: _fee, name: "Fee"),
                SizedBox(height: 8),
                TextLabel('Tag'),
                SizedBox(height: 4),
                TextFormFields(controller: _tag, name: "Tag"),
                SizedBox(height: 8),
                TextLabel('Location'),
                SizedBox(height: 4),
                TextFormFields(controller: _location, name: "Location"),
                SizedBox(height: 8),
                TextLabel('Time Available'),
                SizedBox(height: 4),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${selectedStartDate?.day}/${selectedStartDate?.month}/${selectedStartDate?.year} - ${selectedEndDate?.day}/${selectedEndDate?.month}/${selectedEndDate?.year}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${selectedStartTime?.hour}:${selectedStartTime?.minute} - ${selectedEndTime?.hour}:${selectedEndTime?.minute}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
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
                    child: Center(
                      child: Text(
                        'Upload your photo',
                        style: TextStyle(
                          color: Color(0xFF9381FF),
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: _images.map((image) {
                    int index = _images.indexOf(image);
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(image,
                              height: 500,
                              width: screenWidth,
                              fit: BoxFit.cover),
                          // IconButton(
                          //   icon: Icon(Icons.delete),
                          //   onPressed: () => _editImage(index),
                          // ),
                          Positioned(
                            top: 5,
                            left: 8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () => _editImage(index),
                              child: Row(
                                children: [
                                  Image.asset('assets/catalog/edit.png'),
                                  SizedBox(width: 3),
                                  Text(
                                    'Change',
                                    style: TextStyle(
                                      color: Color(0xFF9381FF),
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // IconButton(
                          //   icon: Icon(Icons.delete, color: Colors.red),
                          //   onPressed: () => _deleteImage(index),
                          // ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF9381FF)),
                              onPressed: () => _deleteImage(index),
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
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            print("Creating catalog...");
                            String combinedDateTimeStart =
                                '${selectedStartDate!.year}-${selectedStartDate!.month.toString().padLeft(2, '0')}-${selectedStartDate!.day.toString().padLeft(2, '0')} ${selectedStartTime!.hour.toString().padLeft(2, '0')}:${selectedStartTime!.minute.toString().padLeft(2, '0')}';

// Format tanggal dan waktu berakhir
                            String combinedDateTimeEnd =
                                '${selectedEndDate!.year}-${selectedEndDate!.month.toString().padLeft(2, '0')}-${selectedEndDate!.day.toString().padLeft(2, '0')} ${selectedEndTime!.hour.toString().padLeft(2, '0')}:${selectedEndTime!.minute.toString().padLeft(2, '0')}';

// Gabungkan keduanya dengan tanda penghubung
                            String availableDate =
                                '$combinedDateTimeStart - $combinedDateTimeEnd';

                            // Convert to String

                            if (await authProvider.createCatalog(
                              categoryid: _selectedValueCategories ?? "",
                              catalogName: _name.text,
                              description: _desc.text,
                              fee: _fee.text,
                              protofolioid: _selectedValueProtofolio!,
                              tag: _tag.text,
                              location: _location.text,
                              availabledate: availableDate,
                              images:
                                  _images, // Assuming you have a list of images
                            )) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddCatalogue(
                                            tabIndex: 0,
                                          )));
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
                            isLoading = false;
                          });
                          // Add your add functionality here
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
                        isLoading ? 'Loading...' : 'Add',
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
          borderSide: BorderSide(
            color: Colors.amberAccent,
            width: 3,
          ),
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

  Widget DropDownInputProtofolio(
      List<ProtofolioModel> options, String? selectedValue) {
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
          _selectedValueProtofolio = newValue;
        });
      },
      items: options.map<DropdownMenuItem<String>>((option) {
        return DropdownMenuItem(
          value: option.id,
          child: Text(option.title!),
        );
      }).toList(),
    );
  }
}
