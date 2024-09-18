import 'package:flutter/material.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  final TextEditingController _code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/payment');
            },
            child: Container(
                width: screenWidth,
                height: 48,
                decoration: BoxDecoration(
                    color: Color(0xFF9381FF),
                    borderRadius: BorderRadius.circular(32)),
                child: Center(
                    child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: "Inter"),
                ))),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Review Summary',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/icons/arrow_back.png'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.35,
                    child: Image.asset(
                      'assets/review_summary.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Titanium Full Package',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'By Sally Mann - Wedding Photography',
                            style: TextStyle(
                              fontSize: 12,
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
                                '4,9',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            '\$650',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color(0xFFA1A1A1),
                                fontFamily: "Inter",
                                fontSize: 10),
                          ),
                          Text(
                            '\$500',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/calendar.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Jadwal Photoshoot',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Kamis, 6 April 2024',
                        style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 14,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        '19:00 - 20:00 WIB',
                        style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 14,
                            fontFamily: 'Inter'),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _code,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter the voucher code',
                  hintStyle: TextStyle(
                    color: Color(0xFF9381FF),
                  ),
                  fillColor: Color(0xFFF8F7FF),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide:
                          BorderSide(color: Colors.amberAccent, width: 3)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                        color: Color(0xFFA1A1A1),
                        fontFamily: "Inter",
                        fontSize: 14),
                  ),
                  Text(
                    'Rp 349.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fee',
                    style: TextStyle(
                        color: Color(0xFFA1A1A1),
                        fontFamily: "Inter",
                        fontSize: 14),
                  ),
                  Text(
                    '-Rp 100.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voucher',
                    style: TextStyle(
                        color: Color(0xFFA1A1A1),
                        fontFamily: "Inter",
                        fontSize: 14),
                  ),
                  Text(
                    '-Rp 100.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp 249.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
