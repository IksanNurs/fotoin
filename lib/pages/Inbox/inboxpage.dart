import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fotoin/pages/Inbox/chat_personal.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Inboxpage extends StatefulWidget {
  @override
  _InboxpageState createState() => _InboxpageState();
}

class _InboxpageState extends State<Inboxpage> {
  final TextEditingController _search = TextEditingController();
 Timer? _timer;
  @override
  void initState() {
    super.initState();
       _getProfileStore();
      // Set timer untuk memperbarui data setiap 1 menit
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _getProfileStore();
    });
  }


  @override
  void dispose() {
    // Membatalkan timer saat widget dihapus
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _getProfileStore() async {
    await Provider.of<AuthProvider>(context, listen: false).getGroupChat();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<AuthProvider>(context).groupchat;
    if (chatModel == null) {
      return Center(child: CircularProgressIndicator()); // Handle the case where chatModel is null
    }
    int maxLength = 40;

    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: chatModel.length,
        itemBuilder: (context, index) {
          final catalog = chatModel[index];
          String originalText = catalog.text ?? "";

          // Tentukan border untuk item pertama
          final border = Border(
            top: index == 0
                ? BorderSide(width: 1, color: const Color.fromARGB(255, 233, 233, 233))
                : BorderSide.none,
            bottom: BorderSide(width: 1, color: const Color.fromARGB(255, 233, 233, 233)),
          );

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPersonal(receiverId: catalog.userId),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: border,
              ),
              child: Row(
                children: [
                  Image.asset('assets/user.png'),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              catalog.chatPartnerName ?? "User",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formatDateTime(catalog.createdAt ?? ""),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          originalText.length > maxLength
                              ? originalText.substring(0, maxLength) + '...'
                              : originalText,
                          style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String formatDateTime(String isoDateTime) {
    // Parsing ISO 8601 string to DateTime object
    DateTime dateTime = DateTime.parse(isoDateTime);

    // Format DateTime to desired string format
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.format(dateTime);
  }
}
