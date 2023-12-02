import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class SucessfulDelivery extends StatefulWidget {
  const SucessfulDelivery({super.key});

  @override
  State<SucessfulDelivery> createState() => _PickingOrdersState();
}

class _PickingOrdersState extends State<SucessfulDelivery> {
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
              .where("trangThaiDonHang", isEqualTo: "Đã giao hàng")
              .snapshots(),
          builder: (context, o) {
            if (o.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  itemCount: o.data!.docs.isNotEmpty ? o.data!.docs.length : 0,
                  itemBuilder: (context, index) {
                    orderS = o.data!.docs[index];
                    List<String> log = [];
                    List<String> logReverse = [];
                    log = List.from(
                      o.data!.docs[index]["logVanChuyen"],
                    );
                    logReverse = log.reversed.toList();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.green,
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
                                              color: Colors.green[100],
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
                                                    o.data!.docs[index]["id"],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  cText(
                                                    "Trạng thái:",
                                                    o.data!.docs[index]
                                                        ["trangThaiDonHang"],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  cText(
                                                    "Ngày giao:",
                                                    o.data!.docs[index]
                                                        ["ngayGiaoHang"],
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
                                                          "${o.data!.docs[index]["nguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        SelectableText(
                                                          "Điện thoại: ${o.data!.docs[index]["sdtNguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        SelectableText(
                                                          "Địa chỉ: ${o.data!.docs[index]["dcNguoiGui"]}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                          color: MColors.green,
                                                          width: 1,
                                                        ),
                                                        left: BorderSide(
                                                          color: MColors.green,
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
                                                            "NGƯỜI NHẬN",
                                                            style: TextStyle(
                                                              color: MColors
                                                                  .darkBlue3,
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
                                                            height: 8,
                                                          ),
                                                          SelectableText(
                                                            "${o.data!.docs[index]["nguoiNhan"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          SelectableText(
                                                            "Điện thoại: ${o.data!.docs[index]["sdtNguoiNhan"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          SelectableText(
                                                            "Địa chỉ: ${o.data!.docs[index]["dcNguoiNhan"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "LỊCH SỬ VẬN CHUYỂN",
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
                                                        SizedBox(
                                                          height: 150,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
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
                                                                      size: 10,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        logReverse[
                                                                            index],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              18,
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
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () async =>
                                          await showAlertDialog(o
                                              .data!.docs[index]["anhLayHang"]
                                              .toString()),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[100],
                                        foregroundColor: MColors.black,
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      child: const Text("Ảnh lấy hàng"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () async =>
                                          await showAlertDialog(o
                                              .data!.docs[index]["anhGiaoHang"]
                                              .toString()),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[100],
                                        foregroundColor: MColors.black,
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      child: const Text("Ảnh giao hàng"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () async {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[100],
                                        foregroundColor: MColors.black,
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      child: const Text("In đơn hàng"),
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

  Future<void> showAlertDialog(String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
          content: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  url,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: MColors.white,
                  backgroundColor: MColors.darkBlue,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
