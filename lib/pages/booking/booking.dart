import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/Inbox/chat_personal.dart';
import 'package:fotoin/pages/booking/form_booking.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/shoping.dart';

final List<Map<String, int>> imgList = [
  {'assets/image/slide/ex_wed1.jpg': 0},
  {'assets/image/slide/ex_wed2.jpeg': 1},
  {'assets/image/slide/ex_wed3.jpeg': 2},
  {'assets/image/slide/ex_wed4.jpeg': 3},
];

class BookingPage extends StatefulWidget {
  final Catalog catalog;
  // const BookingPage({super.key, this.catalog});
  //  final String email;
  BookingPage(this.catalog);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  CarouselController buttonCarouselController = CarouselController();
  late TabController _tabController;
  late ScrollController _scrollControllerReview;

  bool showAll = true;
  bool showWithPhoto = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
        _scrollControllerReview = ScrollController();
    _scrollControllerReview.addListener(() {
      print(_scrollControllerReview.hasClients );
      print( _scrollControllerReview.offset);
      setState(() {});
    });
  }

  @override
  void dispose() {
     _scrollControllerReview.dispose();
    _tabController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    final TextEditingController _search = TextEditingController();

    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNav(context),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              widget.catalog.title ?? "",
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
                items: (widget.catalog.gallery != null &&
                        widget.catalog.gallery!.isNotEmpty)
                    ? widget.catalog.gallery!.map((img) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    (img.imageUrl ?? "")),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        });
                      }).toList()
                    : imgList.map((img) {
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 12),
                  color: Colors.white,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 60,
                      padEnds: false,
                      viewportFraction: 0.22,
                      enableInfiniteScroll: false,
                      autoPlayInterval: Duration(seconds: 6),
                    ),
                    items: (widget.catalog.gallery != null &&
                            widget.catalog.gallery!.isNotEmpty)
                        ? widget.catalog.gallery!
                            .asMap()
                            .entries
                            .map((entry) {
                            int index = entry.key;
                            var img = entry.value;
          
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    buttonCarouselController.jumpToPage(
                                        index); // Menggunakan index
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          (img.imageUrl ?? "")),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList()
                        : imgList.map((img) {
                            return Builder(builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  buttonCarouselController
                                      .jumpToPage(img.values.first);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 5),
                                  // margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          img.keys.first.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF8F7FF)),
                      child: Text(
                        widget.catalog.category?.name ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9381FF),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),
                        Text(
                          widget.catalog.averageRating ?? "",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/user.png'),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.catalog.owner?.companyName ?? "",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Company',
                                      style: TextStyle(
                                        color: Color(0xFFA1A1A1),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          widget.catalog.location ?? "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        Text(
                                          ' Indonesia',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9381FF),
                            ),
                            child: Text(
                              'Visit shop',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Inter'),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA1A1A1),
                      ),
                    ),
                    Text(
                     "Rp ${widget.catalog.price??"0"} ",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9381FF),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: "Description"),
                      Tab(text: "PortFolio"),
                      Tab(text: "Review"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(), //
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextUL(widget.catalog.description),
                              // TextUL2('Half Day Documentation 1 Crew for Photo + 1 Crew for Video'),
                              // TextUL2('25 Edit Photos'),
                              // TextUL2('1 Minute Cinematic Video for Instagram'),
                              // TextUL2('Free All RAW Files'),
          
                              // TextUL('Prewedding Package'),
                              // TextUL2('Half Day Documentation 1 Crew for Photo + 1 Crew for Video'),
                              // TextUL2('Free All RAW Files'),
                              // TextUL2('25 Edit Photos'),
          
                              // TextUL('Gold Wedding Packag'),
                              // TextUL2('Full Day Documentation 1 Photographer by Crew + 1 Photographer by Adri Hermawan'),
                              // TextUL2('Full Day Documentation 2 Crew for Video'),
                              // TextUL2('Full Video 1-2 Hours Duration'),
                              // TextUL2('Same Day Edit Video'),
                              // TextUL2('1 Minute Wedding Cinematic Highlight for Social Media'),
                              // TextUL2('50 Edit Photos'),
                              // TextUL2('Sneak Peek by Adri Hermawan'),
                              // TextUL2('Free Canvas 60x40 Include Frame'),
                              // TextUL2('Free 2 Album 20x30 [ 20 Pages ] Hard Cover'),
                              // TextUL2('Free All RAW Files'),
                              // TextUL2('Flashdisk for all files'),
                            ]),
                      ),
                      // Center(child: Text('Description Content')),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of columns
                            mainAxisSpacing: 10, // spacing between rows
                            crossAxisSpacing: 10, // spacing between columns
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(), //
                          children: [
                            Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                        (widget.catalog.portofolio != null && widget.catalog.portofolio!.gallery != null && widget.catalog.portofolio!.gallery!.isNotEmpty)
                      ? (widget.catalog.portofolio!.gallery![0].path ?? "")
                      : "assets/portfolio/foto2.png",
                                    width: 150,
                                    height: 108,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset('assets/portfolio/foto2.png'); // Fallback image
                                    },
                  ),
                                ),
                                Text(
                                  widget.catalog.portofolio?.title??"",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.catalog.portofolio != null && widget.catalog.portofolio!.gallery!.isNotEmpty? widget.catalog.portofolio!.gallery!.length.toString():'0',
                                  style: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontSize: 10,
                                      fontFamily: 'Inter'),
                                )
                              ],
                            )),
                       ],
                        ),
                      ),
                      Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.symmetric(vertical: BorderSide(color: const Color.fromARGB(255, 235, 235, 235)))
                      ),
                   child: ListView(
  children: widget.catalog.reviews != null && widget.catalog.reviews!.isNotEmpty
      ? widget.catalog.reviews!.map((review) {
          return ListWithPhoto(
            review: review, // Pass the review data to the widget if needed
          );
        }).toList()
      : [ // Provide an empty list if no reviews are available
          Center(child: Text('No reviews available')), // Placeholder widget
        ],
),


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

  Widget TextUL(param) {
    return Text(
      param,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Color(0xFFA1A1A1),
      ),
    );
  }

  Widget TextUL2(param) {
    return Text(
      '- ' + param,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Color(0xFFA1A1A1),
      ),
    );
  }

  Widget BottomNav(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatPersonal(receiverId: widget.catalog.ownerId,)));
                },
                child: Icon(
                  Icons.chat,
                  color: Color(0xFF9381FF),
                )),
            ShoppingCartIcon(catalog: int.parse(widget.catalog.id??"0")),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormBooking(catalog: widget.catalog)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9381FF),
                  ),
                  child: Text(
                    'Book Now ',
                    style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class ListAll extends StatelessWidget {
  const ListAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/user.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Liyanadrian',
                            style: TextStyle(
                              color: Color(0xFF9381FF),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                              Text(
                                '4,9',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Text(
                            'The photo results are really good',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '5 Juny 2024',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 PM',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite_border),
                  Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/user.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Liyanadrian',
                            style: TextStyle(
                              color: Color(0xFF9381FF),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                              Text(
                                '4,9',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Text(
                            'The photo results are really good',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '5 Juny 2024',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 PM',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite_border),
                  Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ListWithPhoto extends StatelessWidget {
  final Reviews? review;
  const ListWithPhoto({super.key, this.review});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), //
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                                                  (review?.photo ?? "")=="" ? review!.photo.toString() : "assets/portfolio/foto2.png",
                        width: 150,
                        height: 108,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/user.png'); // Fallback image
                        },
                                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review?.reviewer?.name??"",
                            style: TextStyle(
                              color: Color(0xFF9381FF),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                              Text(
                                review!.rating.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Text(
                            review?.text??'',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Container(
                            child: Image.asset('assets/portfolio/foto1.png'),
                          ),
                          Row(
                            children: [
                              Text(
                                '5 Juny 2024',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1 PM',
                                style: TextStyle(
                                  color: Color(0xFFA1A1A1),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              // Column(
              //   children: [
              //     Icon(Icons.favorite_border),
              //     Text(
              //       '1',
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 12,
              //         fontFamily: 'Inter',
              //       ),
              //     )
              //   ],
              // )
            
            ],
          ),
        ),
        SizedBox(height: 10,)
     ],
    );
  }
}
