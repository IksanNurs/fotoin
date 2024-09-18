import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/booking_status.dart';
import 'package:fotoin/model/cart.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/Inbox/chat_personal.dart';
import 'package:fotoin/pages/booking/booking.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Cartpage extends StatefulWidget {
  @override
  _CartpageState createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _comment = TextEditingController();
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  CartModel? cartmodel;
  List<BookingStatus> appointments = [];
  List<BookingStatus> dones = [];
  double _rating = 0; // I
  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getCart(type: "1");
    var ap = await Provider.of<AuthProvider>(context, listen: false)
        .getBookingStatus(status: 'APPOINTMENT');
    var done = await Provider.of<AuthProvider>(context, listen: false)
        .getBookingStatus(status: 'ACCEPTED');
    if (mounted) {
      setState(() {
        appointments = ap;
        dones = done;
      });
    }
  }

  Future<void> _pickImage(ImageSource source, StateSetter setState) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  String formatDateTime(String isoDateTime) {
    // Parsing ISO 8601 string to DateTime object
    if (isoDateTime!=""){
      DateTime dateTime = DateTime.parse(isoDateTime);

    // Format DateTime to desired string format
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.format(dateTime);
    }
    return "";
  }

  void _editImage(int index, StateSetter setState) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
      });
    }
  }

  void _deleteImage(int index, StateSetter setState) {
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
                                      (catalog.catalog?.gallery != null &&
                                              catalog
                                                  .catalog!.gallery!.isNotEmpty)
                                          ? (catalog.catalog!.gallery![0]
                                                  .imageUrl ??
                                              "")
                                          : "assets/catalog/img-1.png",
                                      width: 150,
                                      height: 108,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/catalog/img-1.png'); // Fallback image
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
                                        Text(catalog.catalog?.title ?? "",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          formatDateTime(
                                              catalog.createdAt ?? ""),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "By " +
                                              (catalog.catalog?.owner
                                                      ?.companyName ??
                                                  "") +
                                              " - " +
                                              catalog.catalog!.description!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
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
                                              catalog.catalog?.averageRating ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          catalog.catalog?.availableDate ?? "",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
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
                                            builder: (context) =>
                                                BookingPage(catalog.catalog!),
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
                      children: appointments.map((catalog) {
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
                                      (catalog.catalog?.gallery != null &&
                                              catalog
                                                  .catalog!.gallery!.isNotEmpty)
                                          ? (catalog.catalog!.gallery![0]
                                                  .imageUrl ??
                                              "")
                                          : "assets/catalog/img-1.png",
                                      width: 150,
                                      height: 108,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/catalog/img-1.png'); // Fallback image
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
                                        Text(catalog.catalog?.title ?? "",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          formatDateTime(
                                              catalog.catalog?.createdAt ?? ""),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "By " +
                                              (catalog.catalog?.owner
                                                      ?.companyName ??
                                                  "") +
                                              " - " +
                                              catalog.catalog!.description!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
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
                                              catalog.catalog?.averageRating ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${catalog.customerInformation?.day} ${catalog.customerInformation?.time}',
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
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
                                            .changeStatusBooking(
                                                id: catalog.id,
                                                status: 'CANCELED');

                                        // Refresh the chat messages
                                        await getProfile();
                                        Fluttertoast.showToast(
                                          msg: "Berhasil Cancel Pembelian",
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
                                        'Cancel',
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
                                            builder: (context) => ChatPersonal(
                                                receiverId: catalog.ownerId),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: Text(
                                        'Chat',
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
                      children: dones.map((catalog) {
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
                                      (catalog.catalog?.gallery != null &&
                                              catalog
                                                  .catalog!.gallery!.isNotEmpty)
                                          ? (catalog.catalog!.gallery![0]
                                                  .imageUrl ??
                                              "")
                                          : "assets/catalog/img-1.png",
                                      width: 150,
                                      height: 108,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/catalog/img-1.png'); // Fallback image
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
                                        Text(catalog.catalog?.title ?? "",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          formatDateTime(
                                              catalog.catalog?.createdAt ?? ""),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "By " +
                                              (catalog.catalog?.owner
                                                      ?.companyName ??
                                                  "") +
                                              " - " +
                                              catalog.catalog!.description!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
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
                                              catalog.catalog?.averageRating ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${catalog.customerInformation?.day} ${catalog.customerInformation?.time}',
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
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
                                      onPressed: () {
                                        setState(() {
                                          _comment.text = '';
                                          _images = [];
                                          _rating = 0;
                                        });
                                        showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
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
                                                            catalog.catalog
                                                                    ?.title ??
                                                                '',
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
                                                          minRating: 0,
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
                                                          'Add Review',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          controller: _comment,
                                                          maxLines: 4,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
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
                                                                  width: 1),
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
                                                                  width: 1),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF9381FF),
                                                                  width: 1),
                                                            ),
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
                                                                              .camera,
                                                                          setState);
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
                                                                              .gallery,
                                                                          setState);
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
                                                                    height: 500,
                                                                    width:
                                                                        screenWidth,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  Positioned(
                                                                    top: 5,
                                                                    left: 8,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ),
                                                                      onPressed: () => _editImage(
                                                                          index,
                                                                          setState),
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
                                                                  Positioned(
                                                                    bottom: 8,
                                                                    right: 8,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Color(0xFF9381FF),
                                                                      ),
                                                                      onPressed: () => _deleteImage(
                                                                          index,
                                                                          setState),
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
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      primaryColor
                                                                          .withOpacity(
                                                                              0.1),
                                                                ),
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
                                                                onPressed:
                                                                    () async {
                                                                  if (await authProvider
                                                                      .createReview(
                                                                    rating: _rating
                                                                        .toString(),
                                                                    text: _comment
                                                                        .text,
                                                                    catalog_id: catalog
                                                                        .catalog!
                                                                        .id
                                                                        .toString(),
                                                                    images:
                                                                        _images,
                                                                  )) {
                                                                     await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .changeStatusBooking(
                                                id: catalog.id,
                                                status: 'DONE');

                                                                    setState(
                                                                        () {});
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        duration:
                                                                            Duration(milliseconds: 1000),
                                                                        backgroundColor:
                                                                            alertColor,
                                                                        content:
                                                                            Text(
                                                                          authProvider
                                                                              .requestModel
                                                                              .message
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      primaryColor,
                                                                ),
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
                                        elevation: 0,
                                        backgroundColor:
                                            primaryColor.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Add Review',
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
                                            builder: (context) =>
                                                BookingPage(catalog.catalog!),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: Text(
                                        'Re-Book',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
