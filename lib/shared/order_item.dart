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
  bool gotOrderIMG = false;
  bool deliveredOrderIMG = false;

  bool isLoading = true;

  String message = "Không tìm thấy đơn hàng";

  List<String> log = [];
  List<String> reversedLog = [];

  var order;
  var picker;
  var shipper;

  get onPressed => null;

  get child => null;

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
        .collection("DeliverOrders")
        .doc(widget.orderID)
        .get();
    if (o.exists) {
      log = List.from(o["logVanChuyen"]);
      if (o["anhLayHang"].isNotEmpty) {
        setState(() {
          gotOrderIMG = true;
        });
      }
      if (o["anhGiaoHang"].isNotEmpty) {
        setState(() {
          deliveredOrderIMG = true;
        });
      }
      if (o["maNVGiaoHang"].isNotEmpty) {
        ship = await FirebaseFirestore.instance
            .collection("Shippers")
            .doc(o["maNVGiaoHang"])
            .get();
        setState(() {
          shipper = ship;
          hasShipper = true;
        });
      }
      if (o["maNVLayHang"].isNotEmpty) {
        pick = await FirebaseFirestore.instance
            .collection("Shippers")
            .doc(o["maNVLayHang"])
            .get();
        setState(() {
          picker = pick;
          hasPicker = true;
        });
      }

      setState(() {
        reversedLog = log.reversed.toList();
        order = o;
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
                                              cText(
                                                  "Mã đơn:", "${order["id"]}"),
                                              const Expanded(child: SizedBox()),
                                              cText("Trạng thái:",
                                                  "${order["trangThaiDonHang"]}"),
                                              const Expanded(child: SizedBox()),
                                              cText("Ngày tạo:",
                                                  "${order["ngayTaoDon"]}"),
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "NGƯỜI GỬI",
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
                                                    Text(
                                                      "Họ tên: ${order["nguoiGui"]}",
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    MText(
                                                      title: "Điện thoại",
                                                      content:
                                                          "${order["sdtNguoiGui"]}",
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    MText(
                                                      title: "Địa chỉ:",
                                                      content:
                                                          "${order["dcNguoiGui"]}",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 180,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: MColors.darkBlue,
                                                      width: 1,
                                                    ),
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "NGƯỜI NHẬN",
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
                                                        "Họ tên: ${order["nguoiNhan"]}",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      MText(
                                                        title: "Điện thoại",
                                                        content:
                                                            "${order["sdtNguoiNhan"]}",
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      MText(
                                                        title: "Địa chỉ:",
                                                        content:
                                                            "${order["dcNguoiNhan"]}",
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
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: MText(
                                                        title: "Tên hàng hóa:",
                                                        content:
                                                            order["tenSanPham"],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: MText(
                                                        title: "Loại hàng hóa:",
                                                        content: order[
                                                            "loaiHangHoa"],
                                                      ),
                                                    ),
                                                    cText(
                                                      "Giá trị hàng hóa:",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["giaTriHangHoa"],
                                                      ),
                                                    ),
                                                    cText(
                                                      "Phí vận chuyển:",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["phiVanChuyen"],
                                                      ),
                                                    ),
                                                    cText(
                                                      "Tiền COD:",
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(
                                                        order["tienThuHo"],
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
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: MText(
                                                                title:
                                                                    "Điện thoại:",
                                                                content:
                                                                    "${picker["phoneNumber"]}",
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: MText(
                                                                title: "Email:",
                                                                content:
                                                                    "${picker["email"]}",
                                                              ),
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
                                                height: 180,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                      color: MColors.darkBlue,
                                                      width: 1,
                                                    ),
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
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: MText(
                                                                title:
                                                                    "Điện thoại:",
                                                                content:
                                                                    "${shipper["phoneNumber"]}",
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: MText(
                                                                title: "Email:",
                                                                content:
                                                                    "${shipper["email"]}",
                                                              ),
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "LỊCH SỬ VẬN CHUYỂN",
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
                                                    SizedBox(
                                                      height: 150,
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
                                                                child: SizedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                    child: Text(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () async =>
                                  await showAlertDialog(order["anhSanPham"]),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Pastel.blue,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: const Text(
                                "Ảnh sản phẩm",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            child: gotOrderIMG
                                ? SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () async =>
                                          await showAlertDialog(
                                              order["anhLayHang"]),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Pastel.blue,
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      child: const Text(
                                        "Ảnh lấy hàng",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          SizedBox(
                            width: gotOrderIMG ? 10 : 0,
                          ),
                          SizedBox(
                            width: 200,
                            child: deliveredOrderIMG
                                ? ElevatedButton(
                                    onPressed: () async =>
                                        await showAlertDialog(
                                            order["anhGiaoHang"]),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Pastel.blue,
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text(
                                      "Ảnh giao hàng",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
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
      padding: const EdgeInsets.symmetric(vertical: 3),
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
