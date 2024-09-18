import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';

class NotaReceiptPage extends StatefulWidget {
  final Catalog? catalog;
  final String? mtod;
  final String? Name;
  final String? Phone;
  final String? transaction_id;
  const NotaReceiptPage(
      {super.key,
      this.catalog,
      this.mtod,
      this.Name,
      this.Phone,
      this.transaction_id});

  @override
  State<NotaReceiptPage> createState() => _NotaReceiptPageState();
}

class _NotaReceiptPageState extends State<NotaReceiptPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'E-Receipt',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
          shadowColor: Color(0x14000000),
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF8F7FF),
                            borderRadius: BorderRadius.circular(24)),
                        width: screenWidth,
                        height: 150,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Photography Shoot For',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            'Commercial',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Photographer',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.catalog?.owner?.companyName ?? "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking Date',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.catalog?.availableDate ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Amount',
                      //       style: TextStyle(
                      //           color: Color(0xFFA1A1A1),
                      //           fontFamily: "Inter",
                      //           fontSize: 16),
                      //     ),
                      //     Text(
                      //       widget.catalog?.price ?? "",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: "Inter",
                      //           fontSize: 16),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Fee',
                      //       style: TextStyle(
                      //           color: Color(0xFFA1A1A1),
                      //           fontFamily: "Inter",
                      //           fontSize: 16),
                      //     ),
                      //     Text(
                      //       widget.catalog?.price ?? "",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: "Inter",
                      //           fontSize: 16),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.catalog?.price ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.Name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.Phone ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Virtual Billing',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Container(
                        
                            child: Text(
                              widget.transaction_id ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Channel Pembayaran',
                            style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 16),
                          ),
                          Text(
                            widget.mtod ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                    width: screenWidth,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Color(0xFF9381FF),
                        borderRadius: BorderRadius.circular(32)),
                    child: Center(
                        child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Inter"),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
