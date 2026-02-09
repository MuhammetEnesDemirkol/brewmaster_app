import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "Sepetim",
          style: TextStyle(
            color: Color(0xFF4E342E),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF4E342E)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              setState(() {
                _cartService.clearCart();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sepet temizlendi")),
              );
            },
          )
        ],
      ),
      body: _cartService.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sepetiniz boş",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _cartService.items.length,
                    itemBuilder: (context, index) {
                      final product = _cartService.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF4E342E),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${product.price} TL",
                                    style: const TextStyle(
                                      color: Color(0xFFC69C6D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _cartService.removeFromCart(product);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Toplam Tutar:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${_cartService.totalPrice} TL",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E342E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Sipariş Alındı! ☕"),
                                content: const Text(
                                  "Siparişiniz hazırlanıyor. Afiyet olsun!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _cartService.clearCart();
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Tamam"),
                                  )
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E342E),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Sepeti Onayla",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

