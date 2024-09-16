import 'dart:developer';

import 'package:my_car_project/app/cart-cycle/models/cart_model.dart';
import 'package:my_car_project/services/dio_client.dart';

class CartApi {
  // Get all products
  Future<List<CartModel>> getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';

    try {
      final response = await DioClient.client.get(url);

      if (response.statusCode == 200) {
        List<CartModel> productList = (response.data as List)
            .map((productJson) => CartModel.fromJson(productJson))
            .toList();
        log(response.data.toString());
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      throw ('register error >> $e');
    }
  }
}