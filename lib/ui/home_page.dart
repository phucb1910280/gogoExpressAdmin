import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:gogo_admin/ui/screens/orders_overview.dart';
import 'package:gogo_admin/ui/screens/overview.dart';
import 'package:gogo_admin/ui/screens/settings.dart';
import 'package:gogo_admin/ui/screens/shippers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const OverviewScreen(),
    const OrdersOverview(),
    const ShippersScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: MColors.background,
            useIndicator: true,
            extended: true,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            selectedLabelTextStyle: const TextStyle(
              fontSize: 17,
              color: MColors.darkBlue,
            ),
            unselectedLabelTextStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
            ),
            selectedIconTheme: const IconThemeData(
              color: MColors.darkBlue,
            ),
            minExtendedWidth: 220,
            leading: Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  height: 60,
                  child: Image.asset(
                    "assets/images/gogoship.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 195,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MColors.darkBlue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "BC Ninh Kiều",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 310),
              child: Text(
                "${FirebaseAuth.instance.currentUser!.email}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Tổng quan'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.local_shipping_outlined),
                selectedIcon: Icon(Icons.local_shipping),
                label: Text('Đơn hàng'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group),
                label: Text('Nhân viên'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Cài đặt'),
              ),
            ],
            selectedIndex: selectedIndex,
          ),
          Expanded(
            child: SizedBox(
              child: screens[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
