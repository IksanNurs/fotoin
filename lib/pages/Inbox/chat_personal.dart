import 'package:flutter/material.dart';
import 'package:fotoin/model/catalog.dart';
import 'package:fotoin/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Import untuk Timer

class ChatPersonal extends StatefulWidget {
  final String? receiverId;

  const ChatPersonal({super.key, this.receiverId});

  @override
  State<ChatPersonal> createState() => _ChatPersonalState();
}

class _ChatPersonalState extends State<ChatPersonal> {
  final TextEditingController _chat = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer; // Timer untuk pembaruan data
  bool _isLoading = true; // Untuk menunjukkan status loading

  @override
  void initState() {
    super.initState();
    _getProfileStore1();

    // Set timer untuk memperbarui data setiap 5 detik
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _getProfileStore();
      
    });
  }

  @override
  void dispose() {
    // Membatalkan timer dan scroll controller saat widget dihapus
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

Future<void> _getProfileStore1() async {
    setState(() {
      _isLoading = true; // Menandakan bahwa data sedang dimuat
    });

    await Provider.of<AuthProvider>(context, listen: false)
        .getChat(receiverId: widget.receiverId);

    if (mounted) {
      setState(() {
        _isLoading = false; // Data telah dimuat
         Future.delayed(Duration(milliseconds: 10), () {
          _scrollToBottom();
        });
      });
    }

  }

  Future<void> _getProfileStore() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .getChat(receiverId: widget.receiverId);

    if (mounted) {
      setState(() {
        // Scroll ke bawah setelah data di-refresh
        Future.delayed(Duration(milliseconds: 10), () {
          _scrollToBottom();
        });
      });
    }
  }

  void _scrollToBottom() {
    // Scroll otomatis ke bawah jika scrollController tidak null
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<AuthProvider>(context).chat;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Chat',
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // User info section
            Container(
              child: Column(
                children: [
                  Image.asset('assets/user.png'),
                  SizedBox(height: 8),
                  Text(
                    chatModel.userReceiver?.name?? "",
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
                      SizedBox(width: 2),
                      Text(
                        chatModel.userReceiver?.city??"",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        chatModel.userReceiver?.province??"",
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
            SizedBox(height: 30),
            // Chat messages list
            Expanded(
              child: _isLoading
                  ? Text("") // Menampilkan indikator loading
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: chatModel.chat?.length ?? 0,
                      itemBuilder: (context, index) {
                        final chat = chatModel.chat?[index];
                        if (chat == null) return SizedBox.shrink();

                        final messageText = chat.text;
                        final isSender = chat.position == "right";

                        return ChatBubble(
                          message: messageText ?? '',
                          isSender: isSender,
                        );
                      },
                    ),
            ),
            // Message input field
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chat,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () async {
              // Hide the keyboard
              FocusScope.of(context).unfocus();

              // Send the message
              if (_chat.text.isNotEmpty) {
                await Provider.of<AuthProvider>(context, listen: false)
                    .createChat(receiverId: int.parse(widget.receiverId ?? "0"), text: _chat.text);

                // Clear the text field
                _chat.clear();

                // Refresh the chat messages
                await _getProfileStore();
              }
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF9381FF),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  ChatBubble({required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
