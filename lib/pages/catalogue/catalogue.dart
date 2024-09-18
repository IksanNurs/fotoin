import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/model/user_model.dart';
import 'package:fotoin/pages/booking/booking.dart';
import 'package:fotoin/pages/catalogue/create_catalog.dart';
import 'package:fotoin/pages/protofolio/create_portfolio.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class AddCatalogue extends StatefulWidget {
  final int? tabIndex;
  const AddCatalogue({super.key, this.tabIndex});

  @override
  State<AddCatalogue> createState() => _AddCatalogueState();
}

class _AddCatalogueState extends State<AddCatalogue>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserModel? userModel;
  getProfile() async {
    await Provider.of<AuthProvider>(context, listen: false).getProfile();
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.tabIndex ?? 0,
    );
    getCatalogs();
    getProfile();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  Future<void> getCatalogs() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .getCatalogsByOwner();
    await Provider.of<AuthProvider>(context, listen: false).getProtofolio();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final catalogModel = Provider.of<AuthProvider>(context).catalogs;
    final protofolioModel = Provider.of<AuthProvider>(context).protofolio;
        final userModel = Provider.of<AuthProvider>(context).userModel;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Image.asset('assets/unduh.png'))
          ],
          centerTitle: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userModel.name??"",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Image.asset('assets/Vector.png')
              ],
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/icons/arrow_back.png'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Image.asset('assets/user.png'),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      userModel.name??"",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Company',
                      style: TextStyle(
                        color: Color(0xFFA1A1A1),
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          (userModel.city??"")+', ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          'Indonesia',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/catalog/icon-catalog-1.png'),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        userModel.countCatalog.toString(),
                        style: TextStyle(
                            color: Color(0xFF9381FF),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Catalog',
                        style: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/catalog/icon-catalog-2.png'),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        userModel.countPorto.toString(),
                        style: TextStyle(
                            color: Color(0xFF9381FF),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Protofolio',
                        style: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/catalog/icon-catalog-3.png'),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        userModel.averageRating==null?'0':userModel.averageRating.toString(),
                        style: TextStyle(
                            color: Color(0xFF9381FF),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Rating',
                        style: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/catalog/icon-catalog-4.png'),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        userModel.totalReviews==null?'0':userModel.totalReviews.toString(),
                        style: TextStyle(
                            color: Color(0xFF9381FF),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Review',
                        style: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: "Catalogue"),
                    Tab(text: "Portfolio"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateCatalogue()),
                              );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF9381FF), width: 3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: screenWidth,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/catalog/plus-circle.png'),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Add Catalogue',
                                  style: TextStyle(
                                      color: Color(0xFF9381FF),
                                      fontFamily: "Inter"),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(
                                  color: Color(0xFF9381FF),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 200,
                          width: screenWidth * 0.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: catalogModel.map((catalog) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child:_buildPackageCard(
                      catalog.owner?.companyName ?? "",
                      catalog.title ?? "title", // Replace with actual property
                      catalog.category?.name ??
                          "description", // Replace with actual property
                      (catalog.gallery != null && catalog.gallery!.isNotEmpty)
                          ? (catalog.gallery![0].imageUrl ?? "")
                          : "assets/catalog/img-1.png",
                      catalog.averageRating ?? "0",
                      catalog.price ?? "0",
                      catalog.price ?? "0",
                      catalog,
                    ),
                  ));
                          
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Jumlah kolom dalam grid
                        mainAxisSpacing: 10, // Spasi antar baris
                        crossAxisSpacing: 10, // Spasi antar kolom
                      ),
                      shrinkWrap: true,
                      itemCount: protofolioModel.length +
                          1, // Jumlah item di grid (termasuk tombol tambah)
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          // Widget untuk tombol tambah portofolio
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreatePortfolio()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 3,
                                  color: Color(0xFF9381FF),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/catalog/plus-circle.png'),
                                  SizedBox(height: 3),
                                  Text(
                                    'Add Portfolio',
                                    style: TextStyle(
                                      color: Color(0xFF9381FF),
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Widget untuk item portofolio
                          final portfolioItem = protofolioModel[
                              index - 1]; // Mengambil data portofolio
                          return GestureDetector(
                            onTap: () {
                              // Tambahkan navigasi ke halaman detail portofolio sesuai kebutuhan
                              // Navigator.of(context).pushNamed('/booking_page');
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                       Image.network(
                                         (portfolioItem.gallery != null && portfolioItem.gallery!.isNotEmpty)
                          ? (portfolioItem.gallery![0].path ?? "")
                          : "assets/catalog/img-1.png",
                                        width: 150,
                                        height: 210,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            width: 210,
                                        height: 210,
                                        fit: BoxFit.cover,
                                              'assets/portfolio/foto1.png'); // Fallback image
                                        },
                                      ),
                                        // Tambahkan tombol Edit jika diperlukan
                                        // Positioned(
                                        //   top: 5,
                                        //   left: 8,
                                        //   child: ElevatedButton(
                                        //     style: ElevatedButton.styleFrom(
                                        //       backgroundColor: Colors.white,
                                        //     ),
                                        //     onPressed: () {},
                                        //     child: Row(
                                        //       children: [
                                        //         Image.asset('assets/catalog/edit.png'),
                                        //         SizedBox(width: 3),
                                        //         Text(
                                        //           'Edit',
                                        //           style: TextStyle(
                                        //             color: Color(0xFF9381FF),
                                        //             fontSize: 10,
                                        //             fontFamily: 'Inter',
                                        //             fontWeight: FontWeight.w500,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                 
                                  Text(
                                    portfolioItem.title ??
                                        "", // Judul dari data
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    portfolioItem.category?.name ??
                                        "", // Jumlah portfolio dari data
                                    style: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    String owner,
    String title,
    String subtitle,
    String imagePath,
    String rating,
    String originalPrice,
    String discountedPrice,
    Catalog catalog,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Add your desired border radius here
                  child: Image.network(
                    imagePath,
                    width: 150,
                    height: 108,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                          'assets/catalog/img-1.png'); // Fallback image
                    },
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "By " + owner + " - " + subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      color: Colors.amber,
                    ),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Rp " + originalPrice,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Color(0xFFA1A1A1),
                    fontFamily: "Inter",
                    fontSize: 8,
                  ),
                ),
                Text(
                  "Rp " + discountedPrice,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.6),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                          catalog,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
