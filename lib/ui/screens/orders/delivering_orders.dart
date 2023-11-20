import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class DeliveringOrders extends StatefulWidget {
  const DeliveringOrders({super.key});

  @override
  State<DeliveringOrders> createState() => _DeliveringOrdersState();
}

class _DeliveringOrdersState extends State<DeliveringOrders> {
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
              "Đơn delay giao hàng",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            delayDeliveryOrders(context),
            const Text(
              "Đơn hàng đang giao",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                height: 400,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Orders")
                      .where("status", isEqualTo: "Đang giao hàng")
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
                                                                  "Users")
                                                              .doc(orderSnap
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "customerID"])
                                                              .snapshots(),
                                                          builder: (context,
                                                              customerSnap) {
                                                            if (customerSnap
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
                                                                        "KHÁCH HÀNG",
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
                                                                        "${customerSnap.data!["fullName"]}",
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
                                                                        "Điện thoại: ${customerSnap.data!["phoneNumber"]}",
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
                                                                        "Địa chỉ: ${customerSnap.data!["address"]}",
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
                                                                      index]
                                                                  ["shipperID"])
                                                              .snapshots(),
                                                          builder: (context,
                                                              shipperSnap) {
                                                            if (shipperSnap
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
                                                                        "NHÂN VIÊN GIAO HÀNG",
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
                                                                                  image: NetworkImage("${shipperSnap.data!["profileImg"]}"),
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
                                                                                    "${shipperSnap.data!["fullName"]}",
                                                                                    style: const TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 8),
                                                                                Text(
                                                                                  "Điện thoại: ${shipperSnap.data!["phoneNumber"]}",
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 8),
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    "Email: ${shipperSnap.data!["email"]}",
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
                                                            "LOG VẬN CHUYỂN",
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

  Widget delayDeliveryOrders(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 400,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("status", isEqualTo: "Delay giao hàng")
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
                                                "Ngày tạo:",
                                                delaySnap.data!.docs[index]
                                                    ["orderDay"],
                                              ),
                                              const Expanded(child: SizedBox()),
                                              cText(
                                                "Trạng thái:",
                                                delaySnap.data!.docs[index]
                                                    ["status"],
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
                                                  "Lý do delay giao hàng:",
                                                  delaySnap.data!.docs[index]
                                                      ["delayDeliveryReason"],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                cText(
                                                  "Ngày hẹn giao hàng:",
                                                  delaySnap.data!.docs[index]
                                                      ["reDeliveryDay"],
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
                                                      .collection("Users")
                                                      .doc(delaySnap
                                                              .data!.docs[index]
                                                          ["customerID"])
                                                      .snapshots(),
                                                  builder:
                                                      (context, customerSnap) {
                                                    if (customerSnap.hasData) {
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
                                                                "KHÁCH HÀNG",
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
                                                                "${customerSnap.data!["fullName"]}",
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
                                                                "Điện thoại: ${customerSnap.data!["phoneNumber"]}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                "Địa chỉ: ${customerSnap.data!["address"]}",
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
                                                          ["shipperID"])
                                                      .snapshots(),
                                                  builder:
                                                      (context, shipperSnap) {
                                                    if (shipperSnap.hasData) {
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
                                                                "NHÂN VIÊN GIAO HÀNG",
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
                                                                              NetworkImage("${shipperSnap.data!["profileImg"]}"),
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
                                                                            "${shipperSnap.data!["fullName"]}",
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
                                                                          "Điện thoại: ${shipperSnap.data!["phoneNumber"]}",
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
                                                                            "Email: ${shipperSnap.data!["email"]}",
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
                                                    "LOG VẬN CHUYỂN",
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
                                                    height: 120,
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
