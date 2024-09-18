import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/wallet.dart';
import 'package:fotoin/pages/wallet/create_wallet.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class IndexWallet extends StatefulWidget {
  final Catalog? catalog;
  final String? senderId;
  final String? receiverId;

  const IndexWallet({super.key, this.catalog, this.receiverId, this.senderId});

  @override
  State<IndexWallet> createState() => _IndexWalletState();
}

class _IndexWalletState extends State<IndexWallet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chat = TextEditingController();
  String saldo = "";
  List<WalletModel> withdraws = [];
  List<WalletModel> incomes = [];
 
  Future<void> getProfileStore() async {
    var saldo1 =
        await Provider.of<AuthProvider>(context, listen: false).getBallance();
    var income =
        await Provider.of<AuthProvider>(context, listen: false).getAllIncome();
    var withdraw = await Provider.of<AuthProvider>(context, listen: false)
        .getAllWithdraw();
    await Provider.of<AuthProvider>(context, listen: false)
        .getNotifictions();
    if (mounted) {
      setState(() {
        saldo = saldo1;
        incomes = income;
        withdraws = withdraw;
    
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print("object update");
    getProfileStore();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool containsNumber(String str) {
  final RegExp regExp = RegExp(r'\d');
  return regExp.hasMatch(str);
}


String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  DateTime localDate = parsedDate.toLocal();
  return "${localDate.toIso8601String().split('T')[0]} ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}";
}


  @override
  Widget build(BuildContext context) {
     final notificationModel = Provider.of<AuthProvider>(context).notification;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Wallet Balance',
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
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wallet Balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    "Rp" + saldo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
   
                           final result= await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateWallet()),
                            );
                            
    if (result == true) {
      getProfileStore(); // Memperbarui data setelah kembali
    }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: primaryColor,
                          ),
                          child: Text(
                            'Withdraw Fund',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize:
                                  16, // Menambahkan ukuran font untuk konsistensi
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 100),
                      SvgPicture.asset(
                        "assets/icons/solar_dollar-linear.svg", // Path ke file SVG
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Notifications"),
                  Tab(text: "Withdraw Funds"),
                  Tab(text: "History Income"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                    ListView(
                     children: notificationModel.where((notif) => containsNumber(notif.body ?? '')).map<Widget>((notif) {
       Color backgroundColor = Colors.white;
                      return Column(
                        children: [
                          Container(
                            color: backgroundColor,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(notif.title ?? ""),
                                  Text("Rp" + (notif.body ?? "")),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatDateTime(notif.createdAt ?? '')),
                                  Text('balance Rp'+(notif.body ?? ''))
                                ],
                              ),
                              leading: Image.asset('assets/icons/Frame 95.png',
                                  fit: BoxFit.fitHeight),
                              tileColor: backgroundColor,
                              titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Color(0xFFB8B8FF),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.16,
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0x7FB8B8FF),
                            height: 0.0,
                            thickness: 0.60,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                 
                  ListView(
                    children: withdraws.map<Widget>((notif) {
                      Color backgroundColor = Colors.white;

                      return Column(
                        children: [
                          Container(
                            color: backgroundColor,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(notif.bankName ?? notif.method!),
                                  Text("Rp" + (notif.amount ?? "")),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          notif.status == 'APPROVE'
                                              ? "[Success]"
                                              : notif.status == 'REJECT'
                                                  ? '[Reject]'
                                                  : '[Request]',
                                          style: TextStyle(
                                            color: notif.status == 'APPROVE'
                                                ? Colors.green
                                                : notif.status == 'REJECT'
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(notif.accountNumber ?? ''),
                                      ],
                                    ),
                                  ),
                                  Text(formatDateTime(notif.createdAt ?? ''))
                                ],
                              ),
                              leading: Image.asset('assets/icons/Frame 95.png',
                                  fit: BoxFit.fitHeight),
                              tileColor: backgroundColor,
                              titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Color(0xFFB8B8FF),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.16,
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0x7FB8B8FF),
                            height: 0.0,
                            thickness: 0.60,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  ListView(
                    children: incomes.map<Widget>((notif) {
                      Color backgroundColor = Colors.white;

                      return Column(
                        children: [
                          Container(
                            color: backgroundColor,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(notif.bankName ?? notif.method!),
                                  Text("Rp" + (notif.amount ?? "")),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          notif.status == 'APPROVE'
                                              ? "[Success]"
                                              : notif.status == 'REJECT'
                                                  ? '[Reject]'
                                                  : '[Request]',
                                          style: TextStyle(
                                            color: notif.status == 'APPROVE'
                                                ? Colors.green
                                                : notif.status == 'REJECT'
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(notif.accountNumber ?? ''),
                                      ],
                                    ),
                                  ),
                                  Text(formatDateTime(notif.createdAt ?? ''))
                                ],
                              ),
                              leading: Image.asset('assets/icons/Frame 95.png',
                                  fit: BoxFit.fitHeight),
                              tileColor: backgroundColor,
                              titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Color(0xFFB8B8FF),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.16,
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0x7FB8B8FF),
                            height: 0.0,
                            thickness: 0.60,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
