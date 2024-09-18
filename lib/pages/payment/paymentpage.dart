import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/payment/e-receipt.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class Paymentpage extends StatefulWidget {
  final Catalog? catalog;
  final String? Name;
  final String? Phone;
  final String? booking_id;
  const Paymentpage(
      {super.key, this.catalog, this.Name, this.Phone, this.booking_id});

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'icon': 'assets/icons/tf-bank.png',
      'title': 'Transfer Bank',
      'subtitle': 'Pembayaran cepat',
      'children': [
        {'title': 'BCA', 'icon': 'assets/bank/bca.png'},
        {'title': 'MANDIRI', 'icon': 'assets/bank/mandiri.png'},
        {'title': 'BNI', 'icon': 'assets/bank/bni.png'},
        {'title': 'CIMB', 'icon': 'assets/bank/cimb.png'},
        {'title': 'BTN', 'icon': 'assets/bank/btn.png'},
        {'title': 'Danamon', 'icon': 'assets/bank/danamon.png'},
        {'title': 'Permata', 'icon': 'assets/bank/permata.png'},
        {'title': 'BRI', 'icon': 'assets/bank/bri.png'},
        {'title': 'BSI', 'icon': 'assets/bank/bsi.png'},
      ],
    },
    {
      'icon': 'assets/icons/credit.png',
      'title': 'Kartu Kredit/Debit',
      'subtitle': 'Pembayaran cicilan fleksibel dan instan cepat',
    },
    {
      'icon': 'assets/icons/cod.png',
      'title': 'Bayar di Tempat (COD)',
      'subtitle': 'Tersedia untuk pembelian produk atau kategori tertentu',
    },
    {
      'icon': 'assets/icons/instan.png',
      'title': 'Pembayaran Instan',
      'subtitle': 'Transaksi digital praktis',
      'children': [
        {'title': 'GoPay', 'icon': 'assets/icons/Gopay.png'},
        {'title': 'OVO', 'icon': 'assets/icons/ovo.png'},
        {'title': 'LinkAja', 'icon': 'assets/icons/link-aja.png'},
        {'title': 'QRIS', 'icon': 'assets/icons/qris.png'},
        {'title': 'Jenius Pay', 'icon': 'assets/icons/jenius.png'},
        {'title': 'JakOne Pay', 'icon': 'assets/icons/jack-one.png'},
        {'title': 'OCTO Clicks', 'icon': 'assets/icons/oc.png'},
        {'title': 'Layanan Syariah LinkAja', 'icon': 'assets/icons/oc.png'},
      ],
    },
    {
      'icon': 'assets/icons/debit.png',
      'title': 'Debit Instan',
      'subtitle': 'Transaksi langsung cepat',
      'children': [
        {'title': 'Direct Debit BRI', 'icon': 'assets/icons/db1.png'},
        {'title': 'OneKlik', 'icon': 'assets/icons/db2.png'},
        {'title': 'Direct Debit Mandiri', 'icon': 'assets/icons/db3.png'},
        {'title': 'OCTO Cash bt CIM Niaga', 'icon': 'assets/icons/db4.png'},
      ],
    },
    {
      'icon': 'assets/icons/bayar-diretail.png',
      'title': 'Bayar Di Gerai Ritail',
      'subtitle': 'Pembayaran di toko lebih mudah',
      'children': [
        {
          'title': 'Alfamart/Alfamidi/Lawson',
          'icon': 'assets/icons/alfamart.png'
        },
        {'title': 'Indomaret/Ceriamart', 'icon': 'assets/icons/indomaret.png'},
        {'title': 'Kantor Pos', 'icon': 'assets/icons/kpos.png'},
        {'title': 'Circle K', 'icon': 'assets/icons/circle.png'},
        {'title': 'Family Mart', 'icon': 'assets/icons/fmart.png'},
        {'title': 'BRI Link', 'icon': 'assets/icons/brilink.png'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(
      msg: "Silahkan pilih metode pembayaran untuk lanjut",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    _onPaymentMethodTap(
        Map<String, dynamic> paymentMethod, String metode) async {
      if (paymentMethod['title'] != 'Transfer Bank') {
        Fluttertoast.showToast(
          msg:
              "Metode pembayaran belum tersedia. Metode pembayaran akan hadir segera.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        var res = await authProvider.createPayment(
            amount:
                (double.tryParse(widget.catalog?.price ?? "0") ?? 0).toInt(),
            bank: metode.toLowerCase(),
            catalogId: widget.catalog?.id,
            orderId: widget.booking_id,
            paymentType: "bank_transfer");
        if (res.item1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptPage(
                        catalog: widget.catalog,
                        Name: widget.Name,
                        Phone: widget.Phone,
                        transaction_id: res.item2,
                        mtod: metode.toLowerCase(),
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor: alertColor,
            content: Text(
              authProvider.requestModel.message.toString(),
              textAlign: TextAlign.center,
            ),
          ));
        }

        // Handle the case for Transfer Bank or navigate to next screen
        print(metode.toLowerCase());
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Payment Methods',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.06,
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    final paymentMethod = paymentMethods[index];
                    return ExpansionTile(
                      leading: Image.asset(paymentMethod['icon']),
                      title: Text(
                        paymentMethod['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        paymentMethod['subtitle'] ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      children: paymentMethod['children'] != null
                          ? paymentMethod['children']
                              .map<Widget>((child) => ListTile(
                                    title: Text(
                                      child['title'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    leading: Image.asset(
                                      child['icon'],
                                    ),
                                    onTap: () => _onPaymentMethodTap(
                                        paymentMethod, child['title']),
                                  ))
                              .toList()
                          : [],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
