import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatefulWidget {
  final String orderID;
  final String customerID;
  final String supplerID;
  final String? deliverID;
  const OrderDetail({
    super.key,
    required this.orderID,
    required this.customerID,
    this.deliverID,
    required this.supplerID,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Đơn hàng - ${widget.orderID}",
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .doc(widget.orderID)
              .snapshots(),
          builder: (context, orderSnapshot) {
            if (orderSnapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(widget.customerID)
                    .snapshots(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Shippers")
                          .doc(widget.deliverID)
                          .snapshots(),
                      builder: (context, shipperSnapshot) {
                        if (shipperSnapshot.hasData) {
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Suppliers")
                                .doc(widget.supplerID)
                                .snapshots(),
                            builder: (context, supplierSnapshot) {
                              if (supplierSnapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 50,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "THÔNG TIN ĐƠN HÀNG",
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: MColors.darkBlue,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Người nhận",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        "${userSnapshot.data!["fullName"]}",
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "SĐT: ${userSnapshot.data!["phoneNumber"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "Địa chỉ: ${userSnapshot.data!["address"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: MColors.darkBlue,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Nhà cung cấp",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        "${supplierSnapshot.data!["brand"]}",
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "SĐT: ${supplierSnapshot.data!["phoneNumber"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "Địa chỉ: ${supplierSnapshot.data!["address"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: MColors.darkBlue,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Hình thức thanh toán:",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            "${orderSnapshot.data!["payments"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Tình trạng thanh toán:",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            "${orderSnapshot.data!["paymentStatus"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Tiền hàng:",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        'vi-VN',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(double.parse(
                                                                    orderSnapshot
                                                                            .data![
                                                                        "totalAmount"])),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Phí vận chuyển:",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        'vi-VN',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(double.parse(
                                                                    orderSnapshot
                                                                            .data![
                                                                        "transportFee"])),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Tổng cộng:",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        'vi-VN',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(double.parse(
                                                                        orderSnapshot.data![
                                                                            "transportFee"]) +
                                                                    double.parse(
                                                                        orderSnapshot
                                                                            .data!["totalAmount"])),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          "THÔNG TIN VẬN CHUYỂN",
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: MColors.darkBlue,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Nhân viên lấy hàng",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        "${shipperSnapshot.data!["fullName"]}",
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "SĐT: ${shipperSnapshot.data!["phoneNumber"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: MColors.darkBlue,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Nhân viên giao hàng",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        "${shipperSnapshot.data!["fullName"]}",
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "SĐT: ${shipperSnapshot.data!["phoneNumber"]}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const Text("err3");
                              }
                            },
                          );
                        } else {
                          return const Text("err2");
                        }
                      },
                    );
                  } else {
                    return const Text("err");
                  }
                },
              );
            } else {
              return const Center(child: Text("Danh sách trống"));
            }
          },
        ),
      ),
    );
  }
}
