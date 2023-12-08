import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class PickingOrders extends StatefulWidget {
  const PickingOrders({super.key});

  @override
  State<PickingOrders> createState() => _PickingOrdersState();
}

class _PickingOrdersState extends State<PickingOrders> {
  List<dynamic> delay = [];
  List<dynamic> picking = [];

  bool hideDelay = true;

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
    var t = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Delay lấy hàng")
        .get();
    var d = t.docs.map((e) => e.toString()).toList();
    var r = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Đang lấy hàng")
        .get();
    var p = r.docs.map((e) => e.toString()).toList();
    setState(() {
      delay = d;
      picking = p;
    });
  }

  Future<void> showImage(String url) async {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Đơn delay lấy hàng (${delay.length})",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  child: delay.isNotEmpty
                      ? SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                hideDelay = !hideDelay;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[400],
                              foregroundColor: Colors.white,
                            ),
                            child: Text(hideDelay == false ? "Ẩn" : "Hiện"),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            hideDelay == false ? delayOrder(context) : const SizedBox(),
            const SizedBox(height: 10),
            Text(
              "Đơn hàng đang lấy (${picking.length})",
              style: const TextStyle(
                fontSize: 20,
                color: MColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SizedBox(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("DeliverOrders")
                      .where("trangThaiDonHang", isEqualTo: "Đang lấy hàng")
                      .snapshots(),
                  builder: (context, o) {
                    if (o.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView.builder(
                          itemCount:
                              o.data!.docs.isNotEmpty ? o.data!.docs.length : 0,
                          itemBuilder: (context, index) {
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
                                                        o.data!.docs[index]
                                                            ["id"],
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      cText(
                                                        "Trạng thái:",
                                                        o.data!.docs[index][
                                                            "trangThaiDonHang"],
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "NGƯỜI GỬI",
                                                            style: TextStyle(
                                                              color: MColors
                                                                  .darkPink,
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
                                                            height: 10,
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
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () =>
                                                                  showImage(o
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      "anhSanPham"]),
                                                              style: ElevatedButton.styleFrom(
                                                                  minimumSize:
                                                                      const Size
                                                                          .fromHeight(
                                                                          40)),
                                                              child: const Text(
                                                                "Ảnh sản phẩm",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Shippers")
                                                            .doc(o.data!
                                                                    .docs[index]
                                                                ["maNVLayHang"])
                                                            .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Container(
                                                              height: 180,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                right:
                                                                    BorderSide(
                                                                  color: MColors
                                                                      .blue,
                                                                ),
                                                                left:
                                                                    BorderSide(
                                                                  color: MColors
                                                                      .blue,
                                                                ),
                                                              )),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "NHÂN VIÊN LẤY HÀNG",
                                                                      style:
                                                                          TextStyle(
                                                                        color: MColors
                                                                            .darkPink,
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
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            image: DecorationImage(
                                                                                image: NetworkImage(
                                                                                  snapshot.data!["profileImg"],
                                                                                ),
                                                                                fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SelectableText(
                                                                                "${snapshot.data!["fullName"]}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 8),
                                                                              SelectableText(
                                                                                "${snapshot.data!["phoneNumber"]}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 17,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 8),
                                                                              SelectableText(
                                                                                "${snapshot.data!["email"]}",
                                                                                style: const TextStyle(
                                                                                  fontSize: 17,
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
                                                                "");
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
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
                                                                color: MColors
                                                                    .darkPink,
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
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              height: 150,
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
                                                                            5.0),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .circle,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Flexible(
                                                                          child:
                                                                              Text(
                                                                            logReverse[index],
                                                                            style:
                                                                                const TextStyle(fontSize: 18),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )),
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
                        child: Text("Loading"),
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("DeliverOrders")
              .where("trangThaiDonHang", isEqualTo: "Delay lấy hàng")
              .snapshots(),
          builder: (context, o) {
            if (o.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  itemCount: o.data!.docs.isNotEmpty ? o.data!.docs.length : 0,
                  itemBuilder: (context, index) {
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
                            color: MColors.yellow,
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
                                          color: Colors.yellow[100],
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
                                              const Expanded(child: SizedBox()),
                                              cText(
                                                "Trạng thái:",
                                                o.data!.docs[index]
                                                    ["trangThaiDonHang"],
                                              ),
                                              const Expanded(child: SizedBox()),
                                              cText(
                                                "Ngày tạo:",
                                                o.data!.docs[index]
                                                    ["ngayTaoDon"],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.yellow[100],
                                          border: Border.all(
                                            color: MColors.orange,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              cText(
                                                "Lý do hoãn đơn:",
                                                o.data!.docs[index]
                                                    ["lyDoHenLay"],
                                              ),
                                              // const Expanded(child: SizedBox()),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              cText(
                                                "Ngày hẹn lấy hàng:",
                                                o.data!.docs[index]
                                                    ["ngayHenLay"],
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
                                                      color: MColors.orange,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
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
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    child: ElevatedButton(
                                                      onPressed: () =>
                                                          showImage(o.data!
                                                                  .docs[index]
                                                              ["anhSanPham"]),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(
                                                                      40)),
                                                      child: const Text(
                                                        "Ảnh sản phẩm",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("Shippers")
                                                    .doc(o.data!.docs[index]
                                                        ["maNVLayHang"])
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      height: 180,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            color:
                                                                MColors.yellow,
                                                          ),
                                                          right: BorderSide(
                                                            color:
                                                                MColors.yellow,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "NHÂN VIÊN LẤY HÀNG",
                                                              style: TextStyle(
                                                                color: MColors
                                                                    .orange,
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
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          snapshot
                                                                              .data!["profileImg"],
                                                                        ),
                                                                        fit: BoxFit.cover),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SelectableText(
                                                                        "${snapshot.data!["fullName"]}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              8),
                                                                      SelectableText(
                                                                        "${snapshot.data!["phoneNumber"]}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              8),
                                                                      SelectableText(
                                                                        "${snapshot.data!["email"]}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
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
                                                    return const Text("");
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
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
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 150,
                                                      child: ListView.builder(
                                                        itemCount: log.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons.circle,
                                                                  size: 12,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    logReverse[
                                                                        index],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )),
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
                child: Text("Loading"),
              );
            }
          },
        ),
      ),
    );
  }
}
