import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  int selectedSize = 1; // 0: S, 1: M, 2: L

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      // Tasarımdaki Alt Barın Aynısı
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFC69C6D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             IconButton(icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28), onPressed: () => Navigator.pop(context)),
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28), onPressed: () {}),
            IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person_outline, color: Colors.white, size: 28), onPressed: () {}),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- ÜST KISIM (Resim ve Arka Plan) ---
            Stack(
              children: [
                // Krem Rengi Arka Plan
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5E6CA), // Açık Krem
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                  ),
                ),
                // Geri ve Kalp Butonları (SafeArea ile hizalı)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, 
                                color: isFavorite ? Colors.red : Colors.black),
                            onPressed: () => setState(() => isFavorite = !isFavorite),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Ortadaki Büyük Resim
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: widget.product.id,
                    child: Center(
                      child: SizedBox(
                        height: 280,
                        width: 280,
                        child: ClipOval(
                          child: Image.asset(widget.product.image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // --- ALT KISIM (Bilgiler) ---
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // İsim ve Fiyat
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4E342E)),
                      ),
                      Text(
                        "${widget.product.price} TL",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4E342E)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Puanlama (Statik)
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text("4.8 (230 İnceleme)", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Açıklama
                  Text(
                    "Yoğun espresso ve buharda ısıtılmış kadifemsi sütün mükemmel uyumu. Günün her saati için ideal bir seçim.",
                    style: TextStyle(color: Colors.grey[600], height: 1.5, fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),

                  // Boyut Seçimi
                  const Text("Boyut Seçiniz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4E342E))),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSizeOption("S", 0),
                      const SizedBox(width: 20),
                      _buildSizeOption("M", 1),
                      const SizedBox(width: 20),
                      _buildSizeOption("L", 2),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Sepete Ekle Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        CartService().addToCart(widget.product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${widget.product.name} sepete eklendi!",
                            ),
                            backgroundColor: const Color(0xFF4E342E),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E342E), // Koyu Kahve
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 5,
                      ),
                      child: const Text("Sepete Ekle", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Boyut Seçim Butonu Yardımcı Metodu
  Widget _buildSizeOption(String size, int index) {
    bool isSelected = selectedSize == index;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E342E) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF4E342E)),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF4E342E),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}