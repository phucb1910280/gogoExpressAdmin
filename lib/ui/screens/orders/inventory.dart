import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
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
        SelectableText(
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
              .collection("DeliverOrders")
              .where("trangThaiDonHang", isEqualTo: "Đã nhập kho")
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
                    log =
                        List.from(orderSnap.data!.docs[index]["logVanChuyen"]);
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
                                                        ["id"],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  cText(
                                                    "Trạng thái:",
                                                    orderSnap.data!.docs[index]
                                                        ["trangThaiDonHang"],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  cText(
                                                    "Ngày tạo:",
                                                    orderSnap.data!.docs[index]
                                                        ["ngayTaoDon"],
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
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "NGƯỜI GỬI",
                                                          style: TextStyle(
                                                            color: MColors
                                                                .darkBlue3,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        SelectableText(
                                                          "${orderSnap.data!.docs[index]["nguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        SelectableText(
                                                          "Điện thoại: ${orderSnap.data!.docs[index]["sdtNguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        SelectableText(
                                                          "Địa chỉ: ${orderSnap.data!.docs[index]["dcNguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
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
                                                              ["maNVLayHang"])
                                                          .snapshots(),
                                                      builder: (context,
                                                          pickupSnap) {
                                                        if (pickupSnap
                                                            .hasData) {
                                                          // orderS = pickupSnap;
                                                          return Container(
                                                            height: 220,
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
                                                                    height: 8,
                                                                  ),
                                                                  SizedBox(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          child:
                                                                              SelectableText(
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
                                                                        SelectableText(
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
                                                                              100,
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
                                                                                          fontSize: 18,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              "...");
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
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              orderS[
                                                                  "anhLayHang"],
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        height: 150,
                                                        width: 150,
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
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MColors.darkBlue3,
                                        foregroundColor: MColors.white,
                                        minimumSize: const Size.fromHeight(
                                          50,
                                        ),
                                      ),
                                      child: const Text(
                                        "In đơn hàng",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                      child: Divider(
                                        color: MColors.darkBlue,
                                        thickness: 0.5,
                                      ),
                                    ),
                                    const Text(
                                      "Điều phối giao hàng",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
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
                                                              ["id"]);
                                                      var t = DateTime.now();
                                                      String newLog =
                                                          "${t.day}/${t.month}: Đang giao hàng";
                                                      log.add(newLog);
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "DeliverOrders")
                                                          .doc(orderSnap.data!
                                                                  .docs[index]
                                                              ["id"])
                                                          .update({
                                                        "trangThaiDonHang":
                                                            "Đang giao hàng",
                                                        "maNVGiaoHang": snapshot
                                                                .data!
                                                                .docs[index]
                                                            ["email"],
                                                        "logVanChuyen":
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
                                            return const Text("...");
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
                child: Text("Loading"),
              );
            }
          },
        ),
      ),
    );
  }
}
