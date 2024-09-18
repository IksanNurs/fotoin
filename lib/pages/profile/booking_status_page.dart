import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/booking_status.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/wallet_admin.dart';
import 'package:fotoin/pages/Inbox/chat_personal.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class PageBookingStatus extends StatefulWidget {
 
  
  const PageBookingStatus({super.key});

  @override
  State<PageBookingStatus> createState() => _PageBookingStatusState();
}

class _PageBookingStatusState extends State<PageBookingStatus> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chat = TextEditingController();
    List<BookingStatus> appointment = [];
    List<BookingStatus> accepted = [];
    List<BookingStatus> cancelled = [];
    List<BookingStatus> done = [];

  Future<void> getProfileStore() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
      var ap =
        await Provider.of<AuthProvider>(context, listen: false).getBookingStatus(type: '1', status: 'APPOINTMENT');
         var ac =
        await Provider.of<AuthProvider>(context, listen: false).getBookingStatus(type: '1', status: 'ACCEPTED');
         var can =
        await Provider.of<AuthProvider>(context, listen: false).getBookingStatus(type: '1', status: 'CANCELED');
          var done =
        await Provider.of<AuthProvider>(context, listen: false).getBookingStatus(type: '1', status: 'DONE');
    if (mounted) {
      setState(() {
       appointment=ap;
       accepted=ac;
       cancelled=can;
       done=done;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getProfileStore();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

   String formatDateTime(String dateTime) {
    if (dateTime!=""){
          DateTime parsedDate = DateTime.parse(dateTime);
    return "${parsedDate.toLocal().toIso8601String().split('T')[0]} ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";
 
    }
    return "";
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Booking Status',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        shadowColor: const Color(0x14000000),
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/icons/arrow_back.png'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Appointment"),
                  Tab(text: "Accepeted"),
                  Tab(text: "Canceled"),
                  Tab(text: "History"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                   ListView(
                       children: appointment.map((catalog) {
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
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => ChatPersonal(
                                                 receiverId: catalog.ownerId),
                                           ),
                                         );
                                       },
                                       style: ElevatedButton.styleFrom(
                                         elevation: 0,
                                         backgroundColor:
                                             primaryColor.withOpacity(0.1),
                                       ),
                                       child: Text(
                                         'Message',
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
                                       onPressed: () async {
                                         await Provider.of<AuthProvider>(context,
                                                 listen: false)
                                             .changeStatusBooking(
                                                 id: catalog.id,
                                                 status: 'ACCEPTED');
                   
                                         // Refresh the chat messages
                                         await getProfileStore();
                                         Fluttertoast.showToast(
                                           msg: "Berhasil Accept Pembelian",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           backgroundColor: Colors.black54,
                                           textColor: Colors.white,
                                           fontSize: 16.0,
                                         );
                                       },
                                      
                                      style: ElevatedButton.styleFrom(
                                         backgroundColor: primaryColor,
                                       ),
                                       child: Text(
                                         'Accepted',
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
                   ListView(
                             children: accepted.map((catalog) {
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
                                               Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                   builder: (context) => ChatPersonal(
                                                       receiverId: catalog.ownerId),
                                                 ),
                                               );
                                             },
                                             style: ElevatedButton.styleFrom(
                                               elevation: 0,
                                               backgroundColor:
                                                   primaryColor.withOpacity(0.1),
                                             ),
                                             child: Text(
                                               'Message',
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
                                             onPressed: () async {
                                               await Provider.of<AuthProvider>(context,
                                                       listen: false)
                                                   .changeStatusBooking(
                                                       id: catalog.id,
                                                       status: 'CANCELED');
                         
                                               // Refresh the chat messages
                                               await getProfileStore();
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
                                               backgroundColor: primaryColor,
                                             ),
                                             child: Text(
                                               'Cancel',
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
                  ListView(
                              children: cancelled.map((catalog) {
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ChatPersonal(
                                                        receiverId: catalog.ownerId),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    primaryColor.withOpacity(0.1),
                                              ),
                                              child: Text(
                                                'Message',
                                                style: TextStyle(
                                                  color: primaryColor,
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
                  ListView(
                                    children: done.map((catalog) {
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
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ChatPersonal(
                                                              receiverId: catalog.ownerId),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          primaryColor.withOpacity(0.1),
                                                    ),
                                                    child: Text(
                                                      'Message',
                                                      style: TextStyle(
                                                        color: primaryColor,
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
           
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
