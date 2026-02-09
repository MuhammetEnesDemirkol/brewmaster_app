import '../models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Product> _items = [];

  List<Product> get items => _items;

  void addToCart(Product product) {
    _items.add(product);
  }

  void removeFromCart(Product product) {
    _items.remove(product);
  }

  void clearCart() {
    _items.clear();
  }

  double get totalPrice =>
      _items.fold(0, (total, current) => total + current.price);
}

