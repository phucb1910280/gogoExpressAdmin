// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:gogo_admin/shared/mtext.dart';
import 'package:intl/intl.dart';

class SearchItem extends StatefulWidget {
  final String orderID;
  const SearchItem({super.key, required this.orderID});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  bool orderExist = false;
  bool hasShipper = false;
  bool hasPicker = false;

  bool isLoading = true;

  String message = "Không tìm thấy đơn hàng";

  List<String> log = [];
  List<String> reversedLog = [];

  var order;
  var user;
  var supplier;
  var picker;
  var shipper;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
    getOrderData();
    super.initState();
  }

  getOrderData() async {
    var ship;
    var pick;
    var o = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.orderID)
        .get();
    if (o.exists) {
      log = List.from(o["deliveryHistory"]);
      var u = await FirebaseFirestore.instance
          .collection("Users")
          .doc(o["customerID"])
          .get();
      var s = await FirebaseFirestore.instance
          .collection("Suppliers")
          .doc(o["supplierID"])
          .get();
      if (o["shipperID"].isNotEmpty) {
        ship = await FirebaseFirestore.instance
            .collection("Shippers")
            .doc(o["shipperID"])
            .get();
        setState(() {
          shipper = ship;
          hasShipper = true;
        });
      }
      if (o["pickupStaffID"].isNotEmpty) {
        pick = await FirebaseFirestore.instance
            .collection("Shippers")
            .doc(o["pickupStaffID"])
            .get();
        setState(() {
          picker = pick;
          hasPicker = true;
        });
      }

      setState(() {
        reversedLog = log.reversed.toList();
        order = o;
        user = u;
        supplier = s;
        orderExist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? orderExist
            ? SizedBox(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 1100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MColors.darkBlue,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Pastel.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              cText("Mã đơn:",
                                                  "${order["orderID"]}"),
                                              const Expanded(child: SizedBox()),
                                              cText("Trạng thái:",
                                                  "${order["status"]}"),
                                              const Expanded(child: SizedBox()),
                                              cText("Ngày tạo:",
                                                  "${order["orderDay"]}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: MColors.darkBlue,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "NHÀ CUNG CẤP",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color:
                                                              MColors.darkBlue,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${supplier["brand"]}",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MText(
                                                        title: "Điện thoại",
                                                        content:
                                                            "${supplier["phoneNumber"]}",
                                                      ),
                                                      MText(
                                                        title: "Địa chỉ:",
                                                        content:
                                                            "${supplier["address"]}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: MColors.darkBlue,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "KHÁCH HÀNG",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color:
                                                              MColors.darkBlue,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${user["fullName"]}",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MText(
                                                        title: "Điện thoại",
                                                        content:
                                                            "${user["phoneNumber"]}",
                                                      ),
                                                      MText(
                                                        title: "Địa chỉ:",
                                                        content:
                                                            "${user["address"]}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "THÔNG TIN ĐƠN HÀNG",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: MColors.darkBlue,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    cText(
                                                      "Tiền hàng",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["orderTotal"],
                                                      ),
                                                    ),
                                                    cText(
                                                      "Phí ship:",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["transportFee"],
                                                      ),
                                                    ),
                                                    cText(
                                                      "Tổng cộng:",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["total"],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        width: 950,
                                        child: Divider(
                                          color: Colors.black26,
                                          thickness: 0.5,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: hasPicker
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "NHÂN VIÊN LẤY HÀNG",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: MColors
                                                                    .darkBlue,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "${picker["fullName"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            MText(
                                                              title:
                                                                  "Điện thoại:",
                                                              content:
                                                                  "${picker["phoneNumber"]}",
                                                            ),
                                                            MText(
                                                              title: "Email:",
                                                              content:
                                                                  "${picker["email"]}",
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(
                                                          child: Text(
                                                            "Chưa điều phối lấy hàng",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                      color: MColors.darkBlue,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: hasShipper
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "NHÂN VIÊN GIAO HÀNG",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: MColors
                                                                    .darkBlue,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "${shipper["fullName"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            MText(
                                                              title:
                                                                  "Điện thoại:",
                                                              content:
                                                                  "${shipper["phoneNumber"]}",
                                                            ),
                                                            MText(
                                                              title: "Email:",
                                                              content:
                                                                  "${shipper["email"]}",
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(
                                                          child: Text(
                                                            "Chưa điều phối giao hàng",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                  color: MColors.darkBlue,
                                                  width: 1,
                                                ))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "LỊCH SỬ VẬN CHUYỂN",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color:
                                                              MColors.darkBlue,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        height: 100,
                                                        child: ListView.builder(
                                                          itemCount: log.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons.circle,
                                                                  size: 8,
                                                                  color: MColors
                                                                      .darkBlue,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        reversedLog[
                                                                            index],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Icon(
                      Icons.cancel,
                      color: MColors.error,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
        : const Center(
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }

  Widget cText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
