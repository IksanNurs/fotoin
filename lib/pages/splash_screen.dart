import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotoin/session_manager.dart';
import '../theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getInit() async {
    // await Provider.of<InfoProvider>(context, listen: false).getInfos();
    // if (mounted) {
    //   setState(() {});
    // }
    // try {
    //   final result = await InternetAddress.lookup('google.com');

    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    Future.delayed(const Duration(seconds: 5), () {
      session.getSession().then((value) async => {
            if (value != "")
              {
                Navigator.pushReplacementNamed(context, '/home'),
              }
            else
              {Navigator.pushReplacementNamed(context, '/onboarding')}
          });
    });

    // }
    // } on SocketException catch (_) {
    //   print('not connected');
    //   if (mounted) {
    //     setState(() {});
    //   }
    // }
  }

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    // InfoModel infoModel = infoProvider.infos;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 37, 170, 226),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(163.4 * 3.14159265 / 90),
              colors: [
                Color(0xFF9381FF),
                Color(0xFFD4CDFF),
                Color(0xFFF8F7FF),
              ],
              stops: [0, 0.6754, 0.9917],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: SpinKitThreeBounce(
                            duration: Duration(seconds: 2),
                            size: 8,
                            itemBuilder: (context, index) {
                              final colors = [
                                Colors.white.withOpacity(0.6),
                                Colors.lightBlue,
                                Color(0xFF9381FF)
                              ];
                              final color = colors[index % colors.length];

                              return DecoratedBox(
                                decoration: BoxDecoration(
                                    color: color, shape: BoxShape.circle),
                              );
                            }),
                      ),
                      Text(
                        "Powered By",
                        style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 0.09,
                      ),
                      Text(
                        "FOTOIN V1",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          color: Color(0xFF9381FF),
                          shadows: [
                            const Shadow(color: Colors.white, blurRadius: 10)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
