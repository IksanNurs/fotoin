import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/wallet_admin.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class IndexWalletAdmin extends StatefulWidget {
  final Catalog? catalog;
  final String? senderId;
  final String? receiverId;
  
  const IndexWalletAdmin({super.key, this.catalog, this.receiverId, this.senderId});

  @override
  State<IndexWalletAdmin> createState() => _IndexWalletAdminState();
}

class _IndexWalletAdminState extends State<IndexWalletAdmin> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chat = TextEditingController();
    List<WalletAdminModel> resquest = [];
  List<WalletAdminModel>  reject = [];
  List<WalletAdminModel>  sucess = [];

//APPROVE/
//REJECT
//
  Future<void> getProfileStore() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
      var r =
        await Provider.of<AuthProvider>(context, listen: false).getAllProgress(type: 'REJECT');
           var pro =
        await Provider.of<AuthProvider>(context, listen: false).getAllProgress(type: 'IN_PROGRESS');
           var app =
        await Provider.of<AuthProvider>(context, listen: false).getAllProgress(type: 'APPROVE');
    if (mounted) {
      setState(() {
       resquest=pro;
       reject=r;
       sucess=app;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getProfileStore();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  DateTime localDate = parsedDate.toLocal();
  return "${localDate.toIso8601String().split('T')[0]} ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Withdraw',
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
                  Tab(text: "Request"),
                  Tab(text: "Reject"),
                  Tab(text: "Success"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                     ListView(
                         children: resquest.map((catalog) {
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
                                  Image.asset('assets/icons/Frame 95.png'),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     SizedBox(
                                       height: 80,
                                       width: 300,
                                       child: Column(
                                         crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                             Text(catalog.accountName ?? "",
                                               maxLines: 1,
                                               style: TextStyle(
                                                   fontSize: 16,
                                                   fontFamily: 'Inter',
                                                   fontWeight: FontWeight.w500,
                                                   overflow:
                                                       TextOverflow.ellipsis)),
                                       
                                           Text(
                                             formatDateTime(
                                                 catalog.createdAt ?? ""),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.normal,
                                             ),
                                           ),
                                             ],
                                           )
                                       ,
                                           SizedBox(
                                             height: 3,
                                           ),
                                     
                                           Text(
                                             "Nominal :"+catalog.amount.toString(),
                                             style: TextStyle(
                                               fontFamily: "Inter",
                                               fontSize: 10,
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "Metode :" + catalog.method.toString(),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: "Inter",
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "No Rekening :" +catalog.accountNumber.toString(),
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
                                               .rejectWithdraw(id: int.parse(catalog.id!));
                     
                                           // Refresh the chat messages
                                           await getProfileStore();
                                           Fluttertoast.showToast(
                                             msg: "item di tolak",
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
                                           'Decline',
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
                                               .approveWithdraw(id: int.parse(catalog.id!));
                     
                                           // Refresh the chat messages
                                           await getProfileStore();
                                           Fluttertoast.showToast(
                                             msg: "item di terima",
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
                                           'Accept',
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
                         children: reject.map((catalog) {
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
                                  Image.asset('assets/icons/Frame 95.png'),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     SizedBox(
                                       height: 80,
                                       width: 300,
                                       child: Column(
                                         crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                             Text(catalog.accountName ?? "",
                                               maxLines: 1,
                                               style: TextStyle(
                                                   fontSize: 16,
                                                   fontFamily: 'Inter',
                                                   fontWeight: FontWeight.w500,
                                                   overflow:
                                                       TextOverflow.ellipsis)),
                                       
                                           Text(
                                             formatDateTime(
                                                 catalog.createdAt ?? ""),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.normal,
                                             ),
                                           ),
                                             ],
                                           )
                                       ,
                                           SizedBox(
                                             height: 3,
                                           ),
                                     
                                           Text(
                                             "Nominal :"+catalog.amount.toString(),
                                             style: TextStyle(
                                               fontFamily: "Inter",
                                               fontSize: 10,
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "Metode :" + catalog.method.toString(),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: "Inter",
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "No Rekening :" +catalog.accountNumber.toString(),
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
                               ],
                             )),
                       );
                     }).toList()),
                      ListView(
                         children: sucess.map((catalog) {
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
                                  Image.asset('assets/icons/Frame 95.png'),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     SizedBox(
                                       height: 80,
                                       width: 300,
                                       child: Column(
                                         crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                             Text(catalog.accountName ?? "",
                                               maxLines: 1,
                                               style: TextStyle(
                                                   fontSize: 16,
                                                   fontFamily: 'Inter',
                                                   fontWeight: FontWeight.w500,
                                                   overflow:
                                                       TextOverflow.ellipsis)),
                                       
                                           Text(
                                             formatDateTime(
                                                 catalog.createdAt ?? ""),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.normal,
                                             ),
                                           ),
                                             ],
                                           )
                                       ,
                                           SizedBox(
                                             height: 3,
                                           ),
                                     
                                           Text(
                                             "Nominal :"+catalog.amount.toString(),
                                             style: TextStyle(
                                               fontFamily: "Inter",
                                               fontSize: 10,
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "Metode :" + catalog.method.toString(),
                                             style: TextStyle(
                                               fontSize: 10,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: "Inter",
                                             ),
                                           ),
                                           SizedBox(
                                             height: 3,
                                           ),
                                           Text(
                                             "No Rekening :" +catalog.accountNumber.toString(),
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
