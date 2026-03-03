import 'package:accure_assignment_app/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        totalAmount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}