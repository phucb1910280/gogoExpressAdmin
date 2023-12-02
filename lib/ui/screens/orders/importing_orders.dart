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
        SelectableText(
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
              .collection("DeliverOrders")
              .where("trangThaiDonHang", isEqualTo: "Đã lấy hàng")
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
                      orderSnap.data!.docs[index]["logVanChuyen"],
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
                                          color: MColors.darkBlue2,
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
                                              color: MColors.lightBlue2,
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
                                                  flex: 2,
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
                                                          return Container(
                                                            height: 220,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                left:
                                                                    BorderSide(
                                                                  color: MColors
                                                                      .darkBlue3,
                                                                  width: 1,
                                                                ),
                                                                right:
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MColors.lightBlue2,
                                        foregroundColor: MColors.black,
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      onPressed: () async {
                                        var t = DateTime.now();
                                        String newLog =
                                            "${t.day}/${t.month}: Đã nhập kho (BC Ninh Kiều)";
                                        log.add(newLog);
                                        await FirebaseFirestore.instance
                                            .collection("DeliverOrders")
                                            .doc(orderSnap.data!.docs[index]
                                                ["id"])
                                            .update({
                                          "trangThaiDonHang": "Đã nhập kho",
                                          "logVanChuyen":
                                              FieldValue.arrayUnion(log),
                                        });
                                      },
                                      child: const Text("Nhập kho"),
                                    ),
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
