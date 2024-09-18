import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/pages/booking/booking.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:fotoin/theme.dart';
import 'package:fotoin/widgets/text_label.dart';
import 'package:provider/provider.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late String _selectedCategory;
  late String _selectedCategoryId;
    List<Catalog> catalogModel = [];
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = '';
    _selectedCategoryId = '';
    getCatalogs();
  }

  Future<void> getCatalogs() async {
    if (_selectedCategoryId.isNotEmpty || _search.text!='') {
     var resp= await Provider.of<AuthProvider>(context, listen: false)
          .getCatalogsByRecomendation(catrgoryId: _selectedCategoryId, search: _search.text);
      Fluttertoast.showToast(
        msg: "Pencarian Selesai",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
       if (mounted){
      setState(() {
        catalogModel=resp.item2;
      });
       }
    } else {
      var resp=await Provider.of<AuthProvider>(context, listen: false).getCatalogs();
        if (mounted){
       setState(() {
        catalogModel=resp.item2;
      });
        }
  
    }
    // if (mounted) {
    //   setState(() {});
    // }
  }


    void _performSearch(String query) {
    // Trigger catalog fetching based on search query
    getCatalogs();
  }
  void _setCategoryId(String? categoryId) {
    setState(() {
      _selectedCategoryId =
          categoryId ?? ''; // If categoryId is null, assign an empty string
      _selectedCategory = filterOptions.firstWhere((option) =>
              option['categoryId'] == _selectedCategoryId)['label'] ??
          ''; // Handle null case for label as well
      getCatalogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _search,
                    onSubmitted:  (query) {
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
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Color.fromARGB(255, 237, 238, 248),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Filters',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: filterOptions.map((option) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        _setCategoryId(option['categoryId']!);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        option['label']!,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                icon: const Icon(Icons.equalizer_outlined),
              )
            ],
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextLabel(
              label: 'Category',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryId =
                              ''; // Handle null case for label as well
                          getCatalogs();
                        });
                 
                      },
                      child: Container(
                        width: 62,
                        height: 61,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 244, 244, 247),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.all_inbox,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'All',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: regular,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Color.fromARGB(255, 237, 238, 248),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          'Filters',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: filterOptions.map((option) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              _setCategoryId(
                                                  option['categoryId']!);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              option['label']!,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Container(
                        width: 62,
                        height: 61,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 244, 244, 247),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.one_k_outlined,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Spesifik',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: regular,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                // You can add more widgets dynamically here based on other categories if needed
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(left: 10),
            height: MediaQuery.of(context).size.height * 0.57,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: catalogModel.length,
              itemBuilder: (context, index) {
                Catalog catalog = catalogModel[index];
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
                    catalog.title ?? "Title",
                    catalog.category?.name ?? "Category",
                    (catalog.gallery != null && catalog.gallery!.isNotEmpty)
                        ? (catalog.gallery![0].imageUrl ?? "")
                        : "assets/catalog/img-1.png",
                    catalog.averageRating ?? "0",
                    catalog.price ?? "0",
                    catalog.price ?? "0",
                    catalog,
                  ),
                );
              },
            ),
          ),
        ],
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
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagePath,
                    width: 200,
                    height: 108,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/catalog/img-1.png',
                        width: 200,
                        height: 108,
                        fit: BoxFit.cover,
                      );
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
                  "By $owner - $subtitle",
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
                  "Rp $originalPrice",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Color(0xFFA1A1A1),
                    fontFamily: "Inter",
                    fontSize: 8,
                  ),
                ),
                Text(
                  "Rp $discountedPrice",
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

final List<Map<String, String>> filterOptions = [
  {'categoryId': '1', 'label': 'Wedding'},
  {'categoryId': '2', 'label': 'Pre-wedding'},
  {'categoryId': '3', 'label': 'Birthday'},
  {'categoryId': '4', 'label': 'Graduation'},
  {'categoryId': '5', 'label': 'Holiday moments'},
  {'categoryId': '6', 'label': 'New born'},
  {'categoryId': '7', 'label': 'Engagement'},
  {'categoryId': '8', 'label': 'Gender reveal'},
  {'categoryId': '9', 'label': 'UMKM Photo'},
  {'categoryId': '10', 'label': 'Family FotoIn'},
  {'categoryId': '11', 'label': 'Lanskap fotografi'},
  {'categoryId': '12', 'label': 'Commercial Advertising photo'},
  {'categoryId': '13', 'label': 'Group photo'},
  {'categoryId': '14', 'label': 'Lain-lain'},
];
