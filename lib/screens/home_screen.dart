import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];
  bool isLoading = true;

  // Kategori Seçimi İçin (Görsel Amaçlı)
  final List<String> categories = ["Tümü", "Sıcak", "Soğuk", "Tatlılar"];
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(response);
    
    setState(() {
      allProducts = data.map((json) => Product.fromJson(json)).toList();
      displayedProducts = allProducts;
      isLoading = false;
    });
  }

  void runFilter(String keyword) {
    List<Product> results = [];
    if (keyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where((product) => product.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      displayedProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Alt Navigasyon Barı (Tasarımdaki gibi)
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFC69C6D), // Açık Kahve Zemin
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home, color: Color(0xFF4E342E), size: 30), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28), onPressed: () {}),
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
            IconButton(icon: const Icon(Icons.person_outline, color: Colors.white, size: 28), onPressed: () {}),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // --- ÜST KISIM (Header + Search + Banner) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Başlık
                        const Text(
                          "Günaydın,\nKahve Sever",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E342E),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 2. Arama Çubuğu
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                            ],
                          ),
                          child: TextField(
                            onChanged: (value) => runFilter(value),
                            decoration: const InputDecoration(
                              hintText: 'Kahvenizi arayın ...',
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 3. İndirim Bannerı
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFC69C6D), Color(0xFFA87B51)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.coffee, color: Color(0xFF4E342E), size: 40),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "%50 İNDİRİM",
                                    style: TextStyle(
                                      color: Color(0xFF4E342E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "İlk siparişe özel",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 4. Kategoriler (Yatay Liste)
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedCategoryIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                              // Filtreleme mantığı buraya eklenebilir
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF4E342E) : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: const Color(0xFF4E342E)),
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: isSelected ? Colors.white : const Color(0xFF4E342E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 5. Ürün Izgarası (Grid)
                  Expanded(
                    child: displayedProducts.isEmpty
                        ? const Center(child: Text("Ürün bulunamadı"))
                        : GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75, // Kartın boyunu ayarlamak için
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: displayedProducts.length,
                            itemBuilder: (context, index) {
                              final product = displayedProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (c) => DetailScreen(product: product)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Resim
                                      Expanded(
                                        child: Hero(
                                          tag: product.id,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: ClipOval( // Resmi yuvarlak yap
                                              child: Image.asset(product.image, fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Yazılar
                                      Text(
                                        product.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4E342E)),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${product.price} TL",
                                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 10),
                                      // Artı Butonu
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF4E342E),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}