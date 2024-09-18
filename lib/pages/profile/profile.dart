import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/helper/help_center.dart';
import 'package:fotoin/pages/helper/privacy_police.dart';
import 'package:fotoin/pages/notification/notification.dart';
import 'package:fotoin/pages/profile/add_profile.dart';
import 'package:fotoin/pages/profile/add_store.dart';
import 'package:fotoin/pages/profile/profile_store.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/session_manager.dart';
import 'package:fotoin/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? userModel;
  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
    await Provider.of<AuthProvider>(context, listen: false).getStores();
    if (mounted) {
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print("object update");
    getProfile();
  }

  store() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStore()),
    );

    if (result == true) {
      getProfile(); // Memperbarui data setelah kembali
    }
  }

 profile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProfile()),
    );

    if (result == true) {
      getProfile(); // Memperbarui data setelah kembali
    }
  }
  store1() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileStore()),
    );

    if (result == true) {
      getProfile(); // Memperbarui data setelah kembali
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<AuthProvider>(context).userModel;
    final storeModel = Provider.of<AuthProvider>(context).storeModel;
    return WillPopScope(
      onWillPop: () async {
        await getProfile(); // Ambil data terbaru sebelum kembali
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SizedBox(height: 20),
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
                userModel.name ?? "",
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
                'User',
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
                    userModel.city ?? "",
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
         
            (storeModel.id??"") == ""
                ? _profileMenu(
                    "Become a Photographer", "assets/icons/aperture.svg",
                    onp: store)
                : _profileMenu("Store", "assets/icons/aperture.svg",
                    onp: store1),
            _profileMenu("Profile", "assets/icons/user.svg", onp: profile),
            _profileMenu("Notifications", "assets/icons/Vector.svg",
                onp: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationCart()))),
            _profileMenu("Help Center", "assets/icons/alert-circle.svg",
                onp: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpCenter()))),
            _profileMenu("Privacy Police", "assets/icons/lock.svg",
                onp: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()))),
            _profileMenu("Log Out", "assets/icons/log-out.svg", onp: logout),
          ],
        ),
      ),
    );
  }

  logout() async {
    await session.clearSession();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/signin', (Route<dynamic> route) => false);
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
