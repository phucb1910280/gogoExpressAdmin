import 'package:flutter/material.dart';
import 'package:gogo_admin/ui/screens/orders/inventory.dart';
import 'package:gogo_admin/ui/screens/orders/delivering_orders.dart';
import 'package:gogo_admin/ui/screens/orders/importing_orders.dart';
import 'package:gogo_admin/ui/screens/orders/new_orders.dart';
import 'package:gogo_admin/ui/screens/orders/picking_orders.dart';
import 'package:gogo_admin/ui/screens/orders/sucessful_delivery.dart';

class OrdersOverview extends StatefulWidget {
  const OrdersOverview({super.key});

  @override
  State<OrdersOverview> createState() => _OrdersOverviewState();
}

class _OrdersOverviewState extends State<OrdersOverview> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(tabs: [
            Tab(
              text: "Đơn hàng mới",
            ),
            Tab(
              text: "Đang lấy hàng",
            ),
            Tab(
              text: "Chờ nhập kho",
            ),
            Tab(
              text: "Tồn kho",
            ),
            Tab(
              text: "Đang giao",
            ),
            Tab(
              text: "Đã giao",
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            NewOrders(),
            PickingOrders(),
            ImportingOrders(),
            Inventory(),
            DeliveringOrders(),
            SucessfulDelivery(),
          ],
        ),
      ),
    );
  }
}
