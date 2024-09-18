import 'package:flutter/material.dart';
import 'package:fotoin/theme.dart';
import 'pages/Inbox/inboxpage.dart';
import 'pages/cart/cartpage.dart';
import 'pages/home/homepage.dart';
import 'pages/profile/profile.dart';
import 'pages/search/searchpage.dart';

class Home extends StatefulWidget {
  static const route = '/home';

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  Color unselectedColor = const Color.fromRGBO(212, 212, 212, 1);

  Color selectedColor = const Color.fromRGBO(147, 129, 255, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(_currentIndex),
      body: _getPage(_currentIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

          },
          iconSize: 28.0,
          unselectedFontSize: 8.0,
          selectedFontSize: 8.0,
          selectedItemColor: selectedColor,
          unselectedItemColor: unselectedColor,
          items: [
            BottomNavigationBarItem(
              icon: _coloredAssetIcon(
                  'assets/home_icon.png',
                  _currentIndex == 0
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _coloredAssetIcon(
                  'assets/inbox_icon.png',
                  _currentIndex == 1
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: _coloredAssetIcon(
                  'assets/search_icon.png',
                  _currentIndex == 2
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _coloredAssetIcon(
                  'assets/cart_icon.png',
                  _currentIndex == 3
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: _coloredAssetIcon(
                  'assets/profile_icon.png',
                  _currentIndex == 4
              ),
              label: 'Profile',
            ),
          ],

        ),
      ),
    );
  }

  AppBar _getAppBar(int index) {
    switch (index) {
      case 0:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
         
          toolbarHeight: 10,
        );
      case 1:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Chat',
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
        );
      case 2:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Search',
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
        );
      case 3:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title:  const Text(
            'Cart',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
          toolbarHeight: 50,
        );
      case 4:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
          // leading: Padding(
          //   padding: const EdgeInsets.only(bottom: 8),
          //   child: Container(
          //     width: 40, // Sesuaikan lebar
          //     height: 40, // Sesuaikan tinggi
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: primaryColor.withOpacity(0.2),
          //     ),
          //     child: IconButton(
          //       icon: Icon(Icons.arrow_back, color: Colors.black),
          //       onPressed: () {
          //         // Aksi ketika tombol ditekan
          //       },
          //     ),
          //   ),
          // ),
          shadowColor: Color(0x14000000),
          toolbarHeight: 50,
        );
      default:
        return AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/appBar_icon.jpg',
            height: 50,
          ),
          toolbarHeight: 50,
        );
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Homepage();
      case 1:
        return Inboxpage();
      case 2:
        return Searchpage();
      case 3:
        return Cartpage();
      case 4:
        return Profile();
      default:
        return Container();
    }
  }

  Widget _coloredAssetIcon(String assetPath, bool isSelected) {
    // Use conditional operator to set the color based on the selected state
    Color color = isSelected ? selectedColor : unselectedColor;

    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: Image.asset(
        assetPath,
        width: 28.0,
        height: 28.0,
      ),
    );
  }
}
