import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class ImportingOrders extends StatefulWidget {
  const ImportingOrders({super.key});

  @override
  State<ImportingOrders> createState() => _PickingOrdersState();
}

class _PickingOrdersState extends State<ImportingOrders> {
  // ignore: prefer_typing_uninitialized_variables
  var orderS;

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
              .where("status", isEqualTo: "Đã lấy hàng")
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
                      orderSnap.data!.docs[index]["deliveryHistory"],
                    );
                    logReverse = log.reversed.toList();
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
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
                                                    "Ngày tạo:",
                                                    orderSnap.data!.docs[index]
                                                        ["orderDay"],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  cText(
                                                    "Trạng thái:",
                                                    orderSnap.data!.docs[index]
                                                        ["status"],
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
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
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
                                                                      height:
                                                                          8),
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
                                                                      height:
                                                                          8),
                                                                  Text(
                                                                    "Điện thoại: ${supplierSnap.data!["phoneNumber"]}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
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
                                                                    "NHÂN VIÊN LẤY HÀNG",
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
                                                                                MColors.blue,
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
                                                          color: MColors.blue,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      var t = DateTime.now();
                                      String newLog =
                                          "${t.day}/${t.month}: Đã nhập kho (BC Ninh Kiều)";
                                      log.add(newLog);
                                      await FirebaseFirestore.instance
                                          .collection("Orders")
                                          .doc(orderSnap.data!.docs[index]
                                              ["orderID"])
                                          .update({
                                        "status": "Đã nhập kho",
                                        "deliveryHistory":
                                            FieldValue.arrayUnion(log),
                                      });
                                    },
                                    child: const Text("Nhập kho"),
                                  ),
                                ],
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
