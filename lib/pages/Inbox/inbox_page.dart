import 'package:flutter/material.dart';

class InboxPages extends StatefulWidget {
  const InboxPages({super.key});

  @override
  State<InboxPages> createState() => _InboxPagesState();
}

class _InboxPagesState extends State<InboxPages> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int maxLength = 40;
    String originalText =
        'Hi, Rahma, welcome to FotoIn. We’re here to make your experience better.';

    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          TextField(
            controller: _search,
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
                  borderSide: BorderSide.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/chat_personal');
            },
            child: Row(
              children: [
                Image.asset('assets/user.png'),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fotoin',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '09.50 PM',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Text(
                        originalText.length > maxLength
                            ? originalText.substring(0, maxLength) + '...'
                            : originalText,
                        style: TextStyle(
                            color: Color(0xFFA1A1A1), fontFamily: 'Inter'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset('assets/user.png'),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fotoin',
                          style: TextStyle(
                              fontFamily: 'Inter', fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '09.50 PM',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Text(
                      originalText.length > maxLength
                          ? originalText.substring(0, maxLength) + '...'
                          : originalText,
                      style: TextStyle(
                          color: Color(0xFFA1A1A1), fontFamily: 'Inter'),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset('assets/user.png'),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fotoin',
                          style: TextStyle(
                              fontFamily: 'Inter', fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '09.50 PM',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Text(
                      originalText.length > maxLength
                          ? originalText.substring(0, maxLength) + '...'
                          : originalText,
                      style: TextStyle(
                          color: Color(0xFFA1A1A1), fontFamily: 'Inter'),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
