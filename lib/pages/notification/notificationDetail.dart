import 'package:flutter/material.dart';
import 'package:fotoin/model/notification.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class NotificationDetail extends StatefulWidget {
  final NotificationModel? notif;
  NotificationDetail(this.notif);
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  void initState() {
    super.initState();
    getNotifRead();
  }

  Future<void> getNotifRead() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .readNotification(id: widget.notif?.id);
    if (mounted) {
      setState(() {});
    }
  }

  String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  DateTime localDate = parsedDate.toLocal();
  return "${localDate.toIso8601String().split('T')[0]} ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}";
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Notification Detail',
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
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
          child: ListView(
            children: [
              Text(widget.notif?.title ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(
                height: 12,
              ),
              Text(
                  "${widget.notif?.body ?? ""}\n${formatDateTime(widget.notif!.createdAt!)}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
