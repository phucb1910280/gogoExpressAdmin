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
              .where("trangThaiDonHang", isEqualTo: "Đã tiếp nhận")
              .snapshots(),
          builder: (context, o) {
            if (o.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  itemCount: o.data!.docs.isNotEmpty ? o.data!.docs.length : 0,
                  itemBuilder: (context, index) {
                    log = List.from(o.data!.docs[index]["logVanChuyen"]);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: MColors.darkPink,
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
                                        color: MColors.darkPink,
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
                                            color: Pastel.pink,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                  "Ngày tạo:",
                                                  o.data!.docs[index]
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "NGƯỜI GỬI",
                                                      style: TextStyle(
                                                        color: MColors.darkPink,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    SelectableText(
                                                      "${o.data!.docs[index]["nguoiGui"]}",
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    SelectableText(
                                                      "Điện thoại: ${o.data!.docs[index]["sdtNguoiGui"]}",
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    SelectableText(
                                                      "Địa chỉ: ${o.data!.docs[index]["dcNguoiGui"]}",
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 190,
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                        color: MColors.darkPink,
                                                        width: 1,
                                                      ),
                                                      left: BorderSide(
                                                        color: MColors.darkPink,
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
                                                          "NGƯỜI NHẬN",
                                                          style: TextStyle(
                                                            color: MColors
                                                                .darkPink,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
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
                                              const SizedBox(width: 20),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "THÔNG TIN ĐƠN HÀNG",
                                                      style: TextStyle(
                                                        color: MColors.darkPink,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                        title: "Tên Sản phẩm:",
                                                        content:
                                                            o.data!.docs[index]
                                                                ["tenSanPham"]),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                        title: "Loại hàng hóa:",
                                                        content: o.data!
                                                                .docs[index]
                                                            ["loaiHangHoa"]),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                      title: "Tiền hàng:",
                                                      content: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(o.data!
                                                                  .docs[index][
                                                              "giaTriHangHoa"]),
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
                                                          .format(o.data!
                                                                  .docs[index]
                                                              ["phiVanChuyen"]),
                                                      size: 16,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    MText(
                                                      title: "Tiền COD:",
                                                      content: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(o.data!
                                                                  .docs[index]
                                                              ["tienThuHo"]),
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
                                      ElevatedButton(
                                        onPressed: () async => showAlertDialog(
                                            o.data!.docs[index]["anhSanPham"]),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Pastel.pink,
                                          foregroundColor: MColors.black,
                                          minimumSize:
                                              const Size.fromHeight(50),
                                        ),
                                        child: const Text("Ảnh sản phẩm"),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                        child: Divider(
                                          color: Colors.black12,
                                          thickness: 1,
                                        ),
                                      ),
                                      const Text(
                                        "Điều phối lấy hàng",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 120,
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
                                                            Pastel.pink,
                                                        foregroundColor:
                                                            MColors.black,
                                                        minimumSize: const Size
                                                            .fromHeight(50),
                                                      ),
                                                      onPressed: () async {
                                                        var t = DateTime.now();
                                                        String newLog =
                                                            "${t.day}/${t.month}: Đang lấy hàng";
                                                        log.add(newLog);
                                                        pickupOrders.add(o.data!
                                                            .docs[index]["id"]);
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "DeliverOrders")
                                                            .doc(o.data!
                                                                    .docs[index]
                                                                ["id"])
                                                            .update({
                                                          "trangThaiDonHang":
                                                              "Đang lấy hàng",
                                                          "maNVLayHang":
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
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
                child: Text("Đang tải"),
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
