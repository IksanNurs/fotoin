import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/booking/booking.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/session_manager.dart';
import 'package:fotoin/theme.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _search = TextEditingController();
  List<Catalog> catalogModelWedding = [];
  List<Catalog> catalogModelGraduation = [];
  List<Catalog> catalogModelFamily = [];

  @override
  void initState() {
    super.initState();
    getCatalogs();
  }

  Future<void> getCatalogs() async {
    var res = await Provider.of<AuthProvider>(context, listen: false).getCatalogsByRecomendation(catrgoryId: "1", search: _search.text);
    var res1 = await Provider.of<AuthProvider>(context, listen: false).getCatalogsByRecomendation(catrgoryId: "4", search: _search.text);
    var res2 = await Provider.of<AuthProvider>(context, listen: false).getCatalogsByRecomendation(catrgoryId: "10", search: _search.text);
    if (res.item1 == 401) {
      un();
      Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
    } else {
      
        setState(() {
          catalogModelWedding = res.item2;
          catalogModelGraduation = res1.item2;
          catalogModelFamily = res2.item2;
        });
      
    }
  }

  void un() async {
    await session.clearSession();
  }

    void _performSearch(String query) {
    // Trigger catalog fetching based on search query
    getCatalogs();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: [
                SizedBox(height: 255), // To leave space for the image at the top
               
                catalogModelWedding.isNotEmpty
                          ? _buildPackageSection(
                              'Wedding Package Recommendations',
                              catalogModelWedding,
                              screenWidth,
                            )
                          : _buildNoDataMessage('Wedding Package Recommendations'),
                      SizedBox(height: 20),
                      catalogModelGraduation.isNotEmpty
                          ? _buildPackageSection(
                              'Graduation Package Recommendations',
                              catalogModelGraduation,
                              screenWidth,
                            )
                          : _buildNoDataMessage('Graduation Package Recommendations'),
                      SizedBox(height: 20),
                      catalogModelFamily.isNotEmpty
                          ? _buildPackageSection(
                              'Family Package Recommendations',
                              catalogModelFamily,
                              screenWidth,
                            )
                          : _buildNoDataMessage('Family Package Recommendations'),
                  
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            right: 20,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                 
                   Row(
                    children: [
                    
                      Expanded(
                        child: TextField(
                          controller: _search,
                          onSubmitted: (query) {
                            _performSearch(query);
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Color(0xFF9381FF),
                            hintText: 'Search Photographer',
                            hintStyle: TextStyle(
                              color: Color(0xFF9381FF),
                            ),
                            fillColor: Color(0xFFF8F7FF),
                            hoverColor: Colors.amber,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                 SizedBox(height: 15,),
                  Container(
                    height: 190,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/Frame 341.png'),
                        fit: BoxFit.fitWidth,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x33B8B8FF),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageSection(String title, List<Catalog> catalogs, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          width: screenWidth,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: catalogs.map((catalog) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(catalog),
                    ),
                  );
                },
                child: _buildPackageCard(
                  catalog.owner?.companyName ?? "",
                  catalog.title ?? "title",
                  catalog.category?.name ?? "description",
                  (catalog.gallery != null && catalog.gallery!.isNotEmpty)
                      ? (catalog.gallery![0].imageUrl ?? "")
                      : "assets/catalog/img-1.png",
                  catalog.averageRating ?? "0",
                  catalog.price ?? "0",
                  catalog.price ?? "0",
                  catalog,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

Widget _buildNoDataMessage(String sectionTitle) {
    return Text("");
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
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagePath,
                    width: 150,
                    height: 108,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/catalog/img-1.png'); // Fallback image
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
                      size: 15,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 15,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 15,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 15,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 15,
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
              bottom: 20,
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
                        builder: (context) => BookingPage(catalog),
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
