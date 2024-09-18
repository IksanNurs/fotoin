import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fotoin/model/booking_status.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/catalogue/catalogue.dart';
import 'package:fotoin/pages/profile/add_profile.dart';
import 'package:fotoin/pages/profile/add_store.dart';
import 'package:fotoin/pages/profile/booking_status_page.dart';
import 'package:fotoin/pages/wallet/index_wallet.dart';
import 'package:fotoin/pages/wallet/index_wallet_admin.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/session_manager.dart';
import 'package:fotoin/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;

class ProfileStore extends StatefulWidget {
  static const route = '/profile';

  @override
  State<ProfileStore> createState() => _ProfileStoreState();
}

class _ProfileStoreState extends State<ProfileStore> {
  UserModel? userModel;
  getProfileStore() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
    await Provider.of<AuthProvider>(context, listen: false).getStores();
    if (mounted) {
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    getProfileStore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print("object update");
    getProfileStore();
  }

  store() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStore()),
    );

    if (result == true) {
      getProfileStore(); // Memperbarui data setelah kembali
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<AuthProvider>(context).userModel;
    final storeModel = Provider.of<AuthProvider>(context).storeModel;
    return WillPopScope(
      onWillPop: () async {
        await getProfileStore(); // Ambil data terbaru sebelum kembali
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: const Text(
              'Store',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Image.asset('assets/icons/arrow_back.png'),
            ),
            shadowColor: Color(0x14000000),
            toolbarHeight: 50),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset('assets/user.png'),
                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: primaryColor.withOpacity(0.3),
                  //   ),
                  //   child: Icon(
                  //     Icons.people,
                  //     size: 60,
                  //     color: primaryColor,
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: Container(
                  //     width: 12,
                  //     height: 12,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: primaryColor,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.3),
                  //           blurRadius: 4,
                  //           spreadRadius: 1,
                  //         ),
                  //       ],
                  //     ),
                  //     child: IconButton(
                  //       padding: EdgeInsets.zero,
                  //       icon: Icon(Icons.edit, size: 20, color: Colors.white),
                  //       onPressed: () {
                  //         // Aksi ketika tombol ditekan
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                storeModel.companyName ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                'Company',
                style: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    storeModel.city ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                  // Text(
                  //   'Indonesia',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 14,
                  //     fontFamily: 'Inter',
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShadowContainer(userModel.bookingAppointment.toString(), "Appointment"),
                  SizedBox(height: 16),
                  _buildShadowContainer(userModel.bookingAccepted.toString(), "Accepted"),
                  SizedBox(height: 16),
                  _buildShadowContainer(userModel.bookingCanceled.toString(), "Canceled"),
                  SizedBox(height: 16),
                  _buildShadowContainer(userModel.bookingDone.toString(), "Done"),
                ],
              ),
            ),
            _profileMenu("Catalog", "assets/icons/grid.svg", onp: catalog),
            _profileMenu("Portfolio", "assets/icons/image.svg",
                onp: protofolio),
             _profileMenu("Booking Status", "assets/icons/eye.svg", onp:bookingStatus),
              
              userModel.isAdmin==true ? _profileMenu("Store Balance", "assets/icons/shopping-bag.svg", onp: walletAdmin):_profileMenu("Store Balance", "assets/icons/shopping-bag.svg", onp: wallet),
          ],
        ),
      ),
    );
  }

  catalog() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddCatalogue(
                tabIndex: 0,
              )),
    );
  }

bookingStatus() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PageBookingStatus()),
    );
  }

   wallet() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IndexWallet(
              )),
    );
  }

   walletAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IndexWalletAdmin(
              )),
    );
  }


  protofolio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddCatalogue(
                tabIndex: 1,
              )),
    );
  }

  Widget _buildShadowContainer(String text, String subtext) {
    return Column(
      children: [
        Container(
          width: 65,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          subtext,
          style: TextStyle(
            fontSize: 12,
            fontWeight: regular,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _profileMenu(String text, String icon, {void Function()? onp}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Tepi tajam
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(0, 1), // Mengatur posisi bayangan
            ),
          ],
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              SvgPicture.asset(
                "assets/icons/navigate_next.svg", // Path ke file SVG
              ),
            ],
          ),
          leading: SvgPicture.asset(
            height: 20,
            icon, // Path ke file SVG
          ),
        ),
      ),
      onPressed: onp,
    );
  }

  Widget _loginOrStore(String status, BuildContext context) {
    return GestureDetector(
      // onTap: (){
      //   if(globals.isLoggedIn){
      //     Navigator.of(context).pushNamed('/store');
      //   } else {
      //     globals.isLoggedIn = true;
      //     globals.username = "Dev ALICE";
      //     setState(() {});
      //   }
      // },
      child: ListView(
        children: [],
      ),
    );
  }
}
