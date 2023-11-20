import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<String> dvpList = [];
  List<String> vvtList = [];
  // ignore: prefer_typing_uninitialized_variables
  var orderS;

  Widget cText(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: MColors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          content,
          style: const TextStyle(
            fontSize: 18,
            color: MColors.white,
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
              .where("status", isEqualTo: "Đã nhập kho")
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
                    orderS = orderSnap.data!.docs[index];
                    List<String> log = [];
                    List<String> logReverse = [];
                    log = List.from(
                        orderSnap.data!.docs[index]["deliveryHistory"]);
                    logReverse = log.reversed.toList();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: MColors.darkBlue3,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: MColors.darkBlue3,
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
                                              color: MColors.darkBlue3,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  flex: 2,
                                                  child: SizedBox(
                                                    child: StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Suppliers")
                                                          .doc(orderSnap.data!
                                                                  .docs[index]
                                                              ["supplierID"])
                                                          .snapshots(),
                                                      builder: (context,
                                                          supplierSnap) {
                                                        if (supplierSnap
                                                            .hasData) {
                                                          return Padding(
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
                                                                        .darkBlue3,
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
                                                  flex: 2,
                                                  child: SizedBox(
                                                    child: StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Shippers")
                                                          .doc(orderSnap.data!
                                                                  .docs[index]
                                                              ["pickupStaffID"])
                                                          .snapshots(),
                                                      builder: (context,
                                                          pickupSnap) {
                                                        if (pickupSnap
                                                            .hasData) {
                                                          // orderS = pickupSnap;
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
                                                                  color: MColors
                                                                      .darkBlue3,
                                                                  width: 1,
                                                                ),
                                                                left:
                                                                    BorderSide(
                                                                  color: MColors
                                                                      .darkBlue3,
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
                                                                    "NHÂN VIÊN LẤY HÀNG",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: MColors
                                                                          .darkBlue3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  SizedBox(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          child:
                                                                              Text(
                                                                            "${pickupSnap.data!["fullName"]}",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5),
                                                                        Text(
                                                                          "Điện thoại: ${pickupSnap.data!["phoneNumber"]}",
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              12,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Text(
                                                                          "LỊCH SỬ VẬN CHUYỂN",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                MColors.darkBlue3,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5),
                                                                        SizedBox(
                                                                          height:
                                                                              80,
                                                                          child:
                                                                              ListView.builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            itemCount:
                                                                                log.length,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(3.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.circle,
                                                                                      size: 10,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        logReverse[index],
                                                                                        style: const TextStyle(
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "ẢNH LẤY HÀNG",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              MColors.darkBlue3,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      SizedBox(
                                                        height: 150,
                                                        width: 150,
                                                        child: Image.network(
                                                          orderS["pickupImg"],
                                                          fit: BoxFit.cover,
                                                        ),
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
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Điều phối giao hàng",
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
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                      .data!.docs.isNotEmpty
                                                  ? snapshot.data!.docs.length
                                                  : 0,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MColors.darkBlue3,
                                                      foregroundColor:
                                                          MColors.white,
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                        50,
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      List<String>
                                                          deliveringOrders =
                                                          List.from(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                              "deliveringOrders"]);
                                                      deliveringOrders.add(
                                                          orderSnap.data!
                                                                  .docs[index]
                                                              ["orderID"]);
                                                      var t = DateTime.now();
                                                      String newLog =
                                                          "${t.day}/${t.month}: Đang giao hàng";
                                                      log.add(newLog);
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("Orders")
                                                          .doc(orderSnap.data!
                                                                  .docs[index]
                                                              ["orderID"])
                                                          .update({
                                                        "status":
                                                            "Đang giao hàng",
                                                        "shipperID": snapshot
                                                                .data!
                                                                .docs[index]
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
                                                        "deliveringOrders":
                                                            FieldValue
                                                                .arrayUnion(
                                                          deliveringOrders,
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
