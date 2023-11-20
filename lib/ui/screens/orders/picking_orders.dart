import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class PickingOrders extends StatefulWidget {
  const PickingOrders({super.key});

  @override
  State<PickingOrders> createState() => _PickingOrdersState();
}

class _PickingOrdersState extends State<PickingOrders> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Đơn delay lấy hàng",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            delayOrder(context),
            const SizedBox(height: 5),
            const Text(
              "Đơn hàng đang lấy",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SizedBox(
                height: 400,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Orders")
                      .where("status", isEqualTo: "Đang lấy hàng")
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
                                      flex: 4,
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[100],
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
                                                        orderSnap.data!
                                                                .docs[index]
                                                            ["orderID"],
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      cText(
                                                        "Trạng thái:",
                                                        orderSnap.data!
                                                                .docs[index]
                                                            ["status"],
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      cText(
                                                        "Ngày tạo:",
                                                        orderSnap.data!
                                                                .docs[index]
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
                                                              .collection(
                                                                  "Suppliers")
                                                              .doc(orderSnap
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "supplierID"])
                                                              .snapshots(),
                                                          builder: (context,
                                                              supplierSnap) {
                                                            if (supplierSnap
                                                                .hasData) {
                                                              return Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
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
                                                                    horizontal:
                                                                        15,
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
                                                                          color:
                                                                              MColors.blue,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle:
                                                                              FontStyle.italic,
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
                                                                              FontWeight.bold,
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
                                                              .doc(orderSnap
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "pickupStaffID"])
                                                              .snapshots(),
                                                          builder: (context,
                                                              pickupSnap) {
                                                            if (pickupSnap
                                                                .hasData) {
                                                              return Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
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
                                                                    horizontal:
                                                                        15,
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        "NV LẤY HÀNG",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              MColors.blue,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              8),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              height: 100,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: NetworkImage("${pickupSnap.data!["profileImg"]}"),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    "${pickupSnap.data!["fullName"]}",
                                                                                    style: const TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 8),
                                                                                Text(
                                                                                  "Điện thoại: ${pickupSnap.data!["phoneNumber"]}",
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 8),
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    "Email: ${pickupSnap.data!["email"]}",
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
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
                                                            "LỊCH SỬ VẬN CHUYỂN",
                                                            style: TextStyle(
                                                              color:
                                                                  MColors.blue,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          SizedBox(
                                                            height: 120,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  log.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          3.0),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          logReverse[
                                                                              index],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                16,
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
                                              const SizedBox(height: 5),
                                            ],
                                          ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget delayOrder(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 400,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("status", isEqualTo: "Delay lấy hàng")
              .snapshots(),
          builder: (context, delaySnap) {
            if (delaySnap.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  itemCount: delaySnap.data!.docs.isNotEmpty
                      ? delaySnap.data!.docs.length
                      : 0,
                  itemBuilder: (context, index) {
                    List<String> log = [];
                    List<String> logReverse = [];
                    log = List.from(
                      delaySnap.data!.docs[index]["deliveryHistory"],
                    );
                    logReverse = log.reversed.toList();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: MColors.orange,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              cText(
                                                "Mã đơn:",
                                                delaySnap.data!.docs[index]
                                                    ["orderID"],
                                              ),
                                              const Expanded(child: SizedBox()),
                                              cText(
                                                "Trạng thái:",
                                                delaySnap.data!.docs[index]
                                                    ["status"],
                                              ),
                                              const Expanded(child: SizedBox()),
                                              cText(
                                                "Ngày tạo:",
                                                delaySnap.data!.docs[index]
                                                    ["orderDay"],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MColors.orange,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                cText(
                                                  "Lý do delay lấy hàng:",
                                                  delaySnap.data!.docs[index]
                                                      ["delayPickupReason"],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                cText(
                                                  "Ngày hẹn lấy hàng:",
                                                  delaySnap.data!.docs[index]
                                                      ["rePickupDay"],
                                                ),
                                              ],
                                            ),
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
                                                      .collection("Suppliers")
                                                      .doc(delaySnap
                                                              .data!.docs[index]
                                                          ["supplierID"])
                                                      .snapshots(),
                                                  builder:
                                                      (context, supplierSnap) {
                                                    if (supplierSnap.hasData) {
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            right: BorderSide(
                                                              color: MColors
                                                                  .orange,
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
                                                                  fontSize: 15,
                                                                  color: MColors
                                                                      .orange,
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
                                                                  fontSize: 20,
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
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                "Địa chỉ: ${supplierSnap.data!["address"]}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
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
                                                      .collection("Shippers")
                                                      .doc(delaySnap
                                                              .data!.docs[index]
                                                          ["pickupStaffID"])
                                                      .snapshots(),
                                                  builder:
                                                      (context, pickupSnap) {
                                                    if (pickupSnap.hasData) {
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            right: BorderSide(
                                                              color: MColors
                                                                  .orange,
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
                                                                "NV LẤY HÀNG",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: MColors
                                                                      .orange,
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
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage("${pickupSnap.data!["profileImg"]}"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
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
                                                                                8),
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
                                                                                8),
                                                                        SizedBox(
                                                                          child:
                                                                              Text(
                                                                            "Email: ${pickupSnap.data!["email"]}",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
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
                                                    "LỊCH SỬ VẬN CHUYỂN",
                                                    style: TextStyle(
                                                      color: MColors.orange,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  SizedBox(
                                                    height: 110,
                                                    child: ListView.builder(
                                                      itemCount: log.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
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
                                                                  logReverse[
                                                                      index],
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                      const SizedBox(height: 5),
                                    ],
                                  ),
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
