import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mtext.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:intl/intl.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({super.key});

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  List<String> log = [];

  Widget cText(String title, String content) {
    return Row(
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
        Text(
          content,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("isNewOrder", isEqualTo: true)
              .snapshots(),
          builder: (context, orderSnap) {
            if (orderSnap.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  itemCount: orderSnap.data!.docs.isNotEmpty
                      ? orderSnap.data!.docs.length
                      : 0,
                  itemBuilder: (context, index) {
                    log = List.from(
                        orderSnap.data!.docs[index]["deliveryHistory"]);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: MColors.blue,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: MColors.blue,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: MColors.background,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                cText(
                                                  "Mã đơn:",
                                                  orderSnap.data!.docs[index]
                                                      ["orderID"],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                cText(
                                                  "Trạng thái:",
                                                  orderSnap.data!.docs[index]
                                                      ["status"],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                cText(
                                                  "Ngày tạo:",
                                                  orderSnap.data!.docs[index]
                                                      ["orderDay"],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("Users")
                                                        .doc(orderSnap.data!
                                                                .docs[index]
                                                            ["customerID"])
                                                        .snapshots(),
                                                    builder:
                                                        (context, userSnap) {
                                                      if (userSnap.hasData) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "KHÁCH HÀNG",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: MColors
                                                                    .blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              "${userSnap.data!["fullName"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              "Điện thoại: ${userSnap.data!["phoneNumber"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              "Địa chỉ: ${userSnap.data!["address"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return const Text(
                                                            "Error");
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("Suppliers")
                                                        .doc(orderSnap.data!
                                                                .docs[index]
                                                            ["supplierID"])
                                                        .snapshots(),
                                                    builder: (context,
                                                        supplierSnap) {
                                                      if (supplierSnap
                                                          .hasData) {
                                                        return Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                color: MColors
                                                                    .blue,
                                                                width: 1,
                                                              ),
                                                              left: BorderSide(
                                                                color: MColors
                                                                    .blue,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 15,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                  "NHÀ CUNG CẤP",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: MColors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 8),
                                                                Text(
                                                                  "${supplierSnap.data!["brand"]}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 8),
                                                                Text(
                                                                  "Điện thoại: ${supplierSnap.data!["phoneNumber"]}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 8),
                                                                Text(
                                                                  "Địa chỉ: ${supplierSnap.data!["address"]}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return const Text(
                                                            "Error");
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "THÔNG TIN THANH TOÁN",
                                                      style: TextStyle(
                                                        color: MColors.blue,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                      title: "Tiền hàng:",
                                                      content: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(orderSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["orderTotal"]),
                                                      size: 16,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                      title: "Phí ship:",
                                                      content: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(orderSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["transportFee"]),
                                                      size: 16,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                      title: "Tổng:",
                                                      content: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(orderSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["total"]),
                                                      size: 16,
                                                      bold: true,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Điều phối lấy hàng",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 150,
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Shippers")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                itemCount: snapshot
                                                        .data!.docs.isNotEmpty
                                                    ? snapshot.data!.docs.length
                                                    : 0,
                                                itemBuilder: (context, index) {
                                                  List<String> pickupOrders =
                                                      List.from(snapshot
                                                              .data!.docs[index]
                                                          ["takingOrders"]);
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            MColors.background,
                                                        minimumSize: const Size
                                                            .fromHeight(50),
                                                      ),
                                                      onPressed: () async {
                                                        var t = DateTime.now();
                                                        String newLog =
                                                            "${t.day}/${t.month}: Đang lấy hàng";
                                                        log.add(newLog);
                                                        pickupOrders.add(
                                                            orderSnap.data!
                                                                    .docs[index]
                                                                ["orderID"]);
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Orders")
                                                            .doc(orderSnap.data!
                                                                    .docs[index]
                                                                ["orderID"])
                                                            .update({
                                                          "status":
                                                              "Đang lấy hàng",
                                                          "isNewOrder": false,
                                                          "pickupStaffID":
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ["email"],
                                                          "deliveryHistory":
                                                              FieldValue
                                                                  .arrayUnion(
                                                            log,
                                                          ),
                                                        });
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Shippers")
                                                            .doc(snapshot.data!
                                                                    .docs[index]
                                                                ["email"])
                                                            .update({
                                                          "takingOrders":
                                                              FieldValue
                                                                  .arrayUnion(
                                                            pickupOrders,
                                                          ),
                                                        });
                                                      },
                                                      child: Text(
                                                        "${snapshot.data!.docs[index]["fullName"]}",
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return const Text("Error");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("Không có đơn mới"),
              );
            }
          },
        ),
      ),
    );
  }
}
