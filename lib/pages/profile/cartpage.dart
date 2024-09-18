import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/cart.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/booking/booking.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  CartModel? cartmodel;
  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getCart(type: "1");
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  String formatDateTime(String isoDateTime) {
    // Parsing ISO 8601 string to DateTime object
    DateTime dateTime = DateTime.parse(isoDateTime);

    // Format DateTime to desired string format
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.format(dateTime);
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

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Set length to 3 for 3 tabs
    getProfile();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartmodel = Provider.of<AuthProvider>(context).cartModel;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Cart"),
                Tab(text: "Order"),
                Tab(text: "History"),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                      children: cartmodel.map((catalog) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 5.0,
                            offset: Offset(0, 1), // Mengatur posisi bayangan
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                            ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                        (catalog.catalog?.gallery != null && catalog.catalog!.gallery!.isNotEmpty)
                      ? (catalog.catalog!.gallery![0].imageUrl ?? "")
                      : "assets/catalog/img-1.png",
                    width: 150,
                    height: 108,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/catalog/img-1.png'); // Fallback image
                    },
                  ),
                ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 120,
                                    width: 190,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    
                                          Text( catalog.catalog?.title??"",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                                      SizedBox(height: 1,),
                                        Text(
                                          formatDateTime(
                                              catalog.createdAt ?? ""),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text(
                                           "By " +  (catalog.catalog?.owner?.companyName ?? "") + " - " + catalog.catalog!.description!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            Icon(
                                              size: 15,
                                              Icons.star_border,
                                              color: Colors.amber,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Text(
                                              catalog.catalog?.averageRating??"",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Text(
                                          catalog.catalog?.availableDate??"",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 3,),
                                        Text(
                                           "Rp " + catalog.catalog!.price!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .deleteCart(id: catalog.id);

                                        // Refresh the chat messages
                                        await getProfile();
                                        Fluttertoast.showToast(
                                          msg: "Item Berhasil di hapus",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            primaryColor.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              16, // Menambahkan ukuran font untuk konsistensi
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(catalog.catalog!),
                    ),
                  );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              16, // Menambahkan ukuran font untuk konsistensi
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    );
                  }).toList()),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                      children: cartmodel.map((catalog) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 5.0,
                            offset: Offset(0, 1), // Mengatur posisi bayangan
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                            ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                        (catalog.catalog?.gallery != null && catalog.catalog!.gallery!.isNotEmpty)
                      ? (catalog.catalog!.gallery![0].imageUrl ?? "")
                      : "assets/catalog/img-1.png",
                    width: 150,
                    height: 108,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/catalog/img-1.png'); // Fallback image
                    },
                  ),
                ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 120,
                                    width: 190,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    
                                          Text( catalog.catalog?.title??"",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                                      SizedBox(height: 1,),
                                        Text(
                                          formatDateTime(
                                              catalog.createdAt ?? ""),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text(
                                           "By " +  (catalog.catalog?.owner?.companyName ?? "") + " - " + catalog.catalog!.description!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            Icon(
                                              size: 15,
                                              Icons.star_border,
                                              color: Colors.amber,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Text(
                                              catalog.catalog?.averageRating??"",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Text(
                                          catalog.catalog?.availableDate??"",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 3,),
                                        Text(
                                           "Rp " + catalog.catalog!.price!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .deleteCart(id: catalog.id);

                                        // Refresh the chat messages
                                        await getProfile();
                                        Fluttertoast.showToast(
                                          msg: "Item Berhasil di hapus",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            primaryColor.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              16, // Menambahkan ukuran font untuk konsistensi
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                double _rating =
                                                    3.0; // Inisialisasi rating

                                                return SingleChildScrollView(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            'Filters',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          'Rating',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        RatingBar.builder(
                                                          initialRating:
                                                              _rating,
                                                          minRating: 1,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            setState(() {
                                                              _rating = rating;
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          'Selected Rating: $_rating',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          'Add Review',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          maxLines:
                                                              4, // Set maximum lines for the text area
                                                          decoration:
                                                              InputDecoration(
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF9381FF),
                                                                  width:
                                                                      1), // Blue border color when focused
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF9381FF),
                                                                  width:
                                                                      1), // Blue border color when enabled
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            10)),
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xFF9381FF),
                                                                    width: 1)),
                                                            hintText:
                                                                'Enter your comments here...',
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          'Add Foto',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .camera),
                                                                    title: Text(
                                                                        'Camera'),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      _pickImage(
                                                                          ImageSource
                                                                              .camera);
                                                                    },
                                                                  ),
                                                                  ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .photo),
                                                                    title: Text(
                                                                        'Gallery'),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      _pickImage(
                                                                          ImageSource
                                                                              .gallery);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFF9381FF),
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            width: screenWidth,
                                                            height: 100,
                                                            child: Center(
                                                              child: Text(
                                                                'Upload your photo',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF9381FF),
                                                                  fontFamily:
                                                                      "Inter",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Column(
                                                          children: _images
                                                              .map((image) {
                                                            int index = _images
                                                                .indexOf(image);
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10),
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: [
                                                                  Image.file(
                                                                      image,
                                                                      height:
                                                                          500,
                                                                      width:
                                                                          screenWidth,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  // IconButton(
                                                                  //   icon: Icon(Icons.delete),
                                                                  //   onPressed: () => _editImage(index),
                                                                  // ),
                                                                  Positioned(
                                                                    top: 5,
                                                                    left: 8,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor:
                                                                              Colors.white),
                                                                      onPressed:
                                                                          () =>
                                                                              _editImage(index),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image.asset(
                                                                              'assets/catalog/edit.png'),
                                                                          SizedBox(
                                                                              width: 3),
                                                                          Text(
                                                                            'Change',
                                                                            style:
                                                                                TextStyle(
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
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor:
                                                                              Color(0xFF9381FF)),
                                                                      onPressed:
                                                                          () =>
                                                                              _deleteImage(index),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image.asset(
                                                                              'assets/icons/trash.png'),
                                                                          SizedBox(
                                                                              width: 3),
                                                                          Text(
                                                                            'Remove',
                                                                            style:
                                                                                TextStyle(
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
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context); // Close the bottom sheet
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    elevation:
                                                                        0,
                                                                    backgroundColor:
                                                                        primaryColor
                                                                            .withOpacity(0.1)),
                                                                child: Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        primaryColor,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  // Handle the rating submission logic here
                                                                  Navigator.pop(
                                                                      context); // Close the bottom sheet
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            primaryColor),
                                                                child: Text(
                                                                  'Submit',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize:
                                              16, // Menambahkan ukuran font untuk konsistensi
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    );
                  }).toList()),
                ),
                
                Center(child: Text("History Content")),
              ],
            ),
          ),
      
        ],
      ),
    );
  }
}
