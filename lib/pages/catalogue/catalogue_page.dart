import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../generated/assets.dart';

final List<Map<String, int>> imgList = [
  {Assets.slideCatalogueExample1: 0},
  {Assets.slideCatalogueExample2: 1},
  {Assets.slideCatalogueExample3: 3},
];

class CataloguePage extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Catalogue',
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
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              autoPlayInterval: Duration(seconds: 6),
            ),
            carouselController: buttonCarouselController,
            items: imgList.map((img) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(img.keys.first.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              });
            }).toList(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 12),
            color: Colors.white,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 50,
                padEnds: false,
                viewportFraction: 0.22,
                enableInfiniteScroll: false,
                autoPlayInterval: Duration(seconds: 6),
              ),
              items: imgList.map((img) {
                return Builder(builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      buttonCarouselController.jumpToPage(img.values.first);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(img.keys.first.toString()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, left: 32),
            child: Text(
              'Wedding Package #1',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, bottom: 8),
            child: Text(
              'Rp 750.000',
              style: TextStyle(
                color: Color(0xFF9381FF),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 32, top: 10, bottom: 10, right: 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x33B8B8FF),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Contains\n',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' 1. Pre-Wedding Photoshoot with 2 concepts\n 2. Wedding D-Day 4 Hours event\n 3. Hard Copy Pre-Wedding Album\n 4. Soft copy 200 files of all Photos\n 5. Wedding D-Day Album\n',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text:
                        '\nIf you want to add some additional, please contact me at “Chat owner” below! we can discuss the price and i may give you some discount coupon~ ',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomButton(),
    );
  }
}

class CustomButton extends StatefulWidget {
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isButton1Pressed = false;
  bool isButton2Pressed = false;
  bool isButton3Pressed = false;

  void _onButton1TapDown(TapDownDetails details) {
    setState(() {
      isButton1Pressed = true;
    });
  }

  void _onButton1TapUp(TapUpDetails details) {
    setState(() {
      isButton1Pressed = false;
    });
  }

  void _onButton2TapDown(TapDownDetails details) {
    setState(() {
      isButton2Pressed = true;
    });
  }

  void _onButton2TapUp(TapUpDetails details) {
    setState(() {
      isButton2Pressed = false;
    });
  }

  void _onButton3TapDown(TapDownDetails details) {
    setState(() {
      isButton3Pressed = true;
    });
  }

  void _onButton3TapUp(TapUpDetails details) {
    setState(() {
      isButton3Pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // Ketinggian navigasi bawah
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
      ),
      child: Row(
        children: [
          // Item pertama
          Expanded(
            flex: 1, // Perbandingan 1
            child: GestureDetector(
              onTap: () {
                print('Chat');
              },
              onTapDown: _onButton1TapDown,
              onTapUp: _onButton1TapUp,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.62, vertical: 4.38),
                      child: SvgPicture.asset(
                        Assets.iconsChatCatalogue,
                        color: isButton1Pressed
                            ? Color(
                                0xFF7361E1) // Warna lebih gelap saat ditekan
                            : Color(0xFF9381FF),
                      ),
                    ),
                    Text(
                      'Chat Store',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isButton1Pressed
                            ? Color(
                                0xFF7361E1) // Warna lebih gelap saat ditekan
                            : Color(0xFF9381FF),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Item kedua
          Expanded(
            flex: 1, // Perbandingan 1
            child: InkWell(
              onTap: () {
                print('Chat');
              },
              onTapDown: _onButton3TapDown,
              onTapUp: _onButton3TapUp,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.62, vertical: 4.38),
                      child: SvgPicture.asset(
                        Assets.iconsAddToChartCatalogue,
                        height: 25,
                        color: isButton3Pressed
                            ? Color(
                                0xFF7361E1) // Warna lebih gelap saat ditekan
                            : Color(0xFF9381FF),
                      ),
                    ),
                    Text(
                      'Add to Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isButton3Pressed
                            ? Color(
                                0xFF7361E1) // Warna lebih gelap saat ditekan
                            : Color(0xFF9381FF),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Item ketiga
          Expanded(
            flex: 2, // Perbandingan 2, dua kali lipat dari yang lainnya
            child: GestureDetector(
              onTap: () {
                print('Order Now');
              },
              onTapDown: _onButton2TapDown,
              onTapUp: _onButton2TapUp,
              child: Container(
                width: 234,
                height: 81,
                decoration: BoxDecoration(
                  color: isButton2Pressed
                      ? Color(0xFF7361E1) // Warna lebih gelap saat ditekan
                      : Color(0xFF9381FF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33B8B8FF),
                      blurRadius: 2,
                      offset: Offset(0, -1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Order Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
