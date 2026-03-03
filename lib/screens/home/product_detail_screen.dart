import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFF0F0F5),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade300,
                        size: 60,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFFF5F7FA),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6C63FF),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF48C6EF)],
                        ).createShader(bounds),
                        child: Text(
                          "₹${product.price}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF43E97B).withValues(alpha:0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "In Stock",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2DBD6E),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 1,
                    color: Colors.grey.withValues(alpha:0.1),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, _) {
          final item = cart.items[product.id];
          final inCart = item != null && item.quantity > 0;

          return Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: inCart
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "In your cart",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade400),
                            ),
                            Text(
                              "${item.quantity} item${item.quantity > 1 ? 's' : ''}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            _stepperButton(
                              icon: Icons.remove_rounded,
                              onTap: () => cart.removeSingleItem(product.id),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                            ),
                            _stepperButton(
                              icon: Icons.add_rounded,
                              onTap: () => cart.addToCart(
                                Product(
                                  id: product.id,
                                  title: item.title,
                                  description: '',
                                  price: item.price,
                                  imageUrl: '',
                                  category: '',
                                ),
                              ),
                              filled: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF48C6EF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withValues(alpha:0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          cart.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text("Added to cart!"),
                                ],
                              ),
                              backgroundColor: const Color(0xFF6C63FF),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_bag_rounded,
                            color: Colors.white, size: 20),
                        label: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _stepperButton({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          gradient: filled
              ? const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48C6EF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: filled ? null : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha:0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : const Color(0xFF6C63FF),
        ),
      ),
    );
  }
}