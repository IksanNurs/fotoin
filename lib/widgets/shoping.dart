import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:fotoin/providers/auth_provider.dart';

class ShoppingCartIcon extends StatefulWidget {
  final int? catalog;

  const ShoppingCartIcon({Key? key, this.catalog}) : super(key: key);

  @override
  _ShoppingCartIconState createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
  }

  Future<void> _onIconTapped() async {
    _controller.forward().then((_) {
      _controller.reverse();
    });

    if (widget.catalog != null) {
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .postCart(type: 1, id: widget.catalog!);

        // Menampilkan toast
        Fluttertoast.showToast(
          msg: "Masuk keranjang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        // Handle any errors here
        Fluttertoast.showToast(
          msg: "Gagal menambahkan ke keranjang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      // Handle case where catalog is null
      Fluttertoast.showToast(
        msg: "Catalog ID tidak tersedia",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onIconTapped,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(
              Icons.shopping_cart,
              color: Color(0xFF9381FF),
            ),
          );
        },
      ),
    );
  }
}
