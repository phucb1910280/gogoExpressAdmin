import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:intl/intl.dart';

class OrderMoney extends StatefulWidget {
  const OrderMoney({super.key});

  @override
  State<OrderMoney> createState() => _OrderMoneyState();
}

class _OrderMoneyState extends State<OrderMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("PostOffice")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, post) {
              if (post.hasData) {
                List<String> shippers = List.from(post.data!["nhanVien"]);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 500,
                      decoration: BoxDecoration(
                        color: Pastel.green40,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Pastel.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Tiền đơn hàng:",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'vi-VN', decimalDigits: 0)
                                      .format(post.data!["tienDonHang"]),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nhân viên giao hàng",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount: shippers.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Shippers")
                                    .doc(shippers[index])
                                    .snapshots(),
                                builder: (context, ship) {
                                  if (ship.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: MColors.background,
                                          border: Border.all(
                                            width: 1,
                                            color: MColors.darkBlue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                ship.data![
                                                                    "profileImg"],
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${ship.data!["fullName"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 7,
                                                            ),
                                                            Text(
                                                              "${ship.data!["phoneNumber"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      "Số tiền đang giữ:",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      'vi-VN',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(ship.data![
                                                              "totalReceivedToday"]),
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async =>
                                                          await confirmPayment(
                                                              double.parse(post
                                                                  .data![
                                                                      "tienDonHang"]
                                                                  .toString()),
                                                              double.parse(ship
                                                                  .data![
                                                                      "totalReceivedToday"]
                                                                  .toString()),
                                                              ship.data![
                                                                  "email"]),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Pastel.green,
                                                        foregroundColor:
                                                            MColors.black,
                                                        minimumSize: const Size
                                                            .fromHeight(60),
                                                      ),
                                                      child: const Text(
                                                        "Xác nhận thanh toán",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Text("");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("");
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> confirmPayment(double t, double s, String id) async {
    await FirebaseFirestore.instance
        .collection("PostOffice")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      "tienDonHang": t + s,
    });
    await FirebaseFirestore.instance.collection("Shippers").doc(id).update({
      "totalReceivedToday": 0,
    });
  }
}
