import 'package:flutter/material.dart';
import 'package:fotoin/pages/notification/notificationDetail.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class NotificationCart extends StatefulWidget {
  @override
  _NotificationCartState createState() => _NotificationCartState();
}

class _NotificationCartState extends State<NotificationCart> {
  Future<void> getNotifications() async {
    await Provider.of<AuthProvider>(context, listen: false).getNotifictions();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

 String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  DateTime localDate = parsedDate.toLocal();
  return "${localDate.toIso8601String().split('T')[0]} ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}";
}

  @override
  Widget build(BuildContext context) {
    final notificationModel = Provider.of<AuthProvider>(context).notification;

    return WillPopScope(
      onWillPop: () async {
        await getNotifications(); // Fetch latest data before popping
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Image.asset('assets/icons/arrow_back.png'),
          ),
          shadowColor: Color(0x14000000),
          toolbarHeight: 50,
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ListView(
            children: notificationModel.map<Widget>((notif) {
              Color backgroundColor =
                  !notif.isRead! ? Colors.grey[200]! : Colors.white;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationDetail(notif)),
                      );

                      if (result == true) {
                        await getNotifications(); // Update data after returning
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                      color: backgroundColor,
                      child: ListTile(
                        title: Text(notif.title ?? ""),
                        subtitle: Text("${formatDateTime(notif.createdAt!)}"),
                        leading: Image.asset('assets/icons/95.png',
                            fit: BoxFit.fitHeight),
                        tileColor: backgroundColor,
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.08,
                        ),
                        subtitleTextStyle: TextStyle(
                          color: Color(0xFFB8B8FF),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.16,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0x7FB8B8FF),
                    height: 0.0,
                    thickness: 0.60,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
