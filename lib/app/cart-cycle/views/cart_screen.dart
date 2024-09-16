import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_car_project/app/cart-cycle/models/cart_model.dart';
import 'package:my_car_project/app/cart-cycle/providers/cart_provider.dart';
import 'package:my_car_project/styles/colors.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all products when the screen is first loaded
    context.read<CartProvider>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      body: cartProvider.isloading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: cartProvider.cartModel.length,
                itemBuilder: (context, index) {
                  final product = cartProvider.cartModel[index];
                  return ShoeCard(product: product);
                },
              ),
            ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  final CartModel product;

  const ShoeCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
              width: 1, color: Color.fromARGB(255, 154, 175, 185))),
      elevation: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(
                    product.image ?? 'assets/images/car.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border_rounded, color: darkblue),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "No Title",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "EGP ${product.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const Text(
                          "2000 EGP",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                          "Review (${product.rating?.rate?.toStringAsFixed(1) ?? '0'})"),
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Add to cart functionality
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: darkblue,
                          child: const Icon(Icons.add, color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
