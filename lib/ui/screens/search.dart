import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:gogo_admin/shared/order_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  String orderID = "";
  bool isWaiting = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1200,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: searchController,
                      maxLength: 12,
                      style: const TextStyle(
                        fontSize: 18,
                        color: MColors.darkBlue,
                      ),
                      decoration: InputDecoration(
                        hintText: "Nhập mã đơn hàng",
                        counterText: "",
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isWaiting = true;
                                searchController.text = "";
                              });
                            },
                            child: const Icon(Icons.clear)),
                        suffixIconColor: Colors.black45,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Pastel.blue,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MColors.darkBlue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor: Pastel.blue,
                      ),
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          setState(() {
                            isWaiting = true;
                            orderID = searchController.text;
                            Timer(const Duration(milliseconds: 300), () {
                              setState(() {
                                isWaiting = false;
                              });
                            });
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        color: MColors.darkBlue,
                      ),
                      label: const Text(
                        "Tìm đơn hàng",
                        style: TextStyle(fontSize: 18, color: MColors.darkBlue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              isWaiting == false
                  ? SearchItem(orderID: orderID)
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
