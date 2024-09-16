import 'package:flutter/material.dart';
import 'package:my_car_project/app/cart-cycle/models/cart_model.dart';
import 'package:my_car_project/app/cart-cycle/services/cartapi.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cartModel =[];
  bool _isloading = true;

  // Getters for vehicles, loading status, and error message
  List<CartModel> get cartModel => _cartModel;
  bool get isloading => _isloading;

  Future<void> getAllProducts() async {
    _isloading = true;
    _cartModel = await CartApi().getAllProducts();
    _isloading = false;
    notifyListeners();
  }
}
