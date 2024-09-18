import 'package:flutter/material.dart';
import 'package:fotoin/home.dart';
import 'package:fotoin/pages/Inbox/chat_personal.dart';
import 'package:fotoin/pages/auth/login.dart';
import 'package:fotoin/pages/auth/register.dart';
import 'package:fotoin/pages/catalogue/create_catalog.dart';
import 'package:fotoin/pages/onboarding_page.dart';
import 'package:fotoin/pages/payment/e-receipt.dart';
import 'package:fotoin/pages/payment/nota-receipt.dart';
import 'package:fotoin/pages/payment/paymentpage.dart';
import 'package:fotoin/pages/profile/add_store.dart';
import 'package:fotoin/pages/profile/profile_store.dart';
import 'package:fotoin/pages/protofolio/create_portfolio.dart';
import 'package:fotoin/pages/splash_screen.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'pages/catalogue/catalogue_page.dart';
import 'pages/profile/add_profile.dart';
import 'pages/profile/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        color: Colors.transparent,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/inbox': (context) => Profile(),
          '/signin': (context) => const Login(),
          '/home': (context) => Home(),
          '/onboarding': (context) => const OnBoardingPage(),
          '/register': (context) => const Register(),
          '/search': (context) =>  Profile(),
          '/cart': (context) => Profile(),
          '/add_store': (context) => AddStore(),
          '/catalogue': (context) => CataloguePage(),
          '/create_catalogue': (context) => CreateCatalogue(),
          '/create_portfolio': (context) => CreatePortfolio(),
          '/payment' : (context) => Paymentpage(),
          '/e-receipt' : (context) => ReceiptPage(),
          '/nota-receipt' : (context) => NotaReceiptPage(),
          '/profile-store' : (context) => ProfileStore(),
        },
      ),
    );
  }
}
