import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/payment/nota-receipt.dart';

class ReceiptPage extends StatefulWidget {
  final Catalog? catalog;
  final String? Name;
  final String? Phone;
  final String? transaction_id;
  final String? mtod;

  const ReceiptPage(
      {super.key,
      this.catalog,
      this.mtod,
      this.Name,
      this.Phone,
      this.transaction_id});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/icons/arrow_back.png'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/congrts.png'),
                  SizedBox(height: 16),
                  Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: "Inter",
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Your photographer is booked',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'You can check your booking in the cart',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotaReceiptPage(
                        catalog: widget.catalog,
                        mtod: widget.mtod?.toLowerCase(),
                        Name: widget.Name,
                        Phone: widget.Phone,
                        transaction_id: widget.transaction_id,
                      ),
                    ),
                  );
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
                      'Continue',
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
    );
  }
}
