import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mtext.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class ShippersScreen extends StatefulWidget {
  const ShippersScreen({super.key});

  @override
  State<ShippersScreen> createState() => _ShippersScreenState();
}

class _ShippersScreenState extends State<ShippersScreen> {
  bool hideFunction = true;
  final _formKey = GlobalKey<FormState>();
  int choice = 1;

  var fullName = TextEditingController();
  var cccd = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var dayOfBirth = TextEditingController();
  var mainAddress = TextEditingController();
  var secondAddress = TextEditingController();
  var password = TextEditingController();

  String id = "";
  String gender = "Nam";
  String joinDay = "";
  String profileImg =
      "https://firebasestorage.googleapis.com/v0/b/gogoship-70cca.appspot.com/o/shipperProfileImages%2Fdfavt.png?alt=media&token=8805717a-9b9d-4b69-98bf-53b43f7f825d";
  double totalReceivedToday = 0;
  String postOffice = "ninhkieu@gogo.com";

  final List<String> deliveringOrders = [];
  final List<String> successfulDeliveryOrders = [];
  final List<String> importOrders = [];
  final List<String> takingOrders = [];
  final List<String> reTakingOrders = [];
  final List<String> redeliveryOrders = [];

  @override
  void initState() {
    var t = DateTime.now();
    setState(() {
      joinDay = "${t.day}/${t.month}/${t.year}";
    });
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    cccd.dispose();
    phoneNumber.dispose();
    email.dispose();
    dayOfBirth.dispose();
    mainAddress.dispose();
    secondAddress.dispose();
    super.dispose();
  }

  Future<void> addShipperData(String shipperID) async {
    await FirebaseFirestore.instance.collection('Shippers').doc(shipperID).set({
      "id": shipperID,
      "fullName": fullName.text,
      "gender": gender,
      "cccd": cccd.text,
      "phoneNumber": phoneNumber.text,
      "email": email.text.trim(),
      "dayOfBirth": dayOfBirth.text,
      "mainAddress": mainAddress.text,
      "secondAddress": secondAddress.text,
      "joinDay": joinDay,
      "postOffice": postOffice,
      "profileImg":
          "https://firebasestorage.googleapis.com/v0/b/gogoship-70cca.appspot.com/o/shipperProfileImages%2Fdfavt.png?alt=media&token=8805717a-9b9d-4b69-98bf-53b43f7f825d",
      "totalReceivedToday": totalReceivedToday,
      "takingOrders": takingOrders,
      "reTakingOrders": reTakingOrders,
      "deliveringOrders": deliveringOrders,
      "redeliveryOrders": redeliveryOrders,
      "importOrders": importOrders,
      "successfulDeliveryOrders": successfulDeliveryOrders,
    });
  }

  void resetTextController() {
    fullName.text = "";
    cccd.text = "";
    phoneNumber.text = "";
    email.text = "";
    dayOfBirth.text = "";
    mainAddress.text = "";
    secondAddress.text = "";
    fullName.text = "";
    gender = "Nam";
    password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hideFunction = !hideFunction;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Pastel.blue,
                      foregroundColor: MColors.black,
                      minimumSize: const Size.fromHeight(40)),
                  child: Text(hideFunction == false ? "Hủy" : "Thêm nhân viên"),
                ),
              ),
              const SizedBox(height: 10),
              hideFunction == false
                  ? SizedBox(
                      height: 450,
                      child: formAddShipper(),
                    )
                  : const SizedBox(),
              SizedBox(
                height: hideFunction == false ? 40 : 5,
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: hideFunction == true ? 15 : 0,
              ),
              const Text(
                "DANH SÁCH NHÂN VIÊN",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 1000,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Shippers")
                        .where("postOffice",
                            isEqualTo: FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, shipperSnap) {
                      if (shipperSnap.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: shipperSnap.data!.docs.isNotEmpty
                              ? shipperSnap.data!.docs.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: MColors.darkBlue3,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      shipperSnap
                                                              .data!.docs[index]
                                                          ["profileImg"],
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                ),
                                                height: 250,
                                                width: 250,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "Họ tên:",
                                                      content: shipperSnap
                                                              .data!.docs[index]
                                                          ["fullName"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "Giới tính:",
                                                      content: shipperSnap
                                                              .data!.docs[index]
                                                          ["gender"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "Ngày sinh:",
                                                      content: shipperSnap
                                                              .data!.docs[index]
                                                          ["dayOfBirth"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "CCCD:",
                                                      content: shipperSnap.data!
                                                          .docs[index]["cccd"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "Điện thoại:",
                                                      content: shipperSnap
                                                              .data!.docs[index]
                                                          ["phoneNumber"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MText(
                                                      title: "Email:",
                                                      content: shipperSnap.data!
                                                          .docs[index]["email"],
                                                      size: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                        color: MColors.darkBlue,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MText(
                                                          title: "Thường trú:",
                                                          content: shipperSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["mainAddress"],
                                                          size: 18,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MText(
                                                          title: "Tạm trú:",
                                                          content: shipperSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["secondAddress"],
                                                          size: 18,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MText(
                                                          title:
                                                              "Ngày tham gia:",
                                                          content: shipperSnap
                                                                  .data!
                                                                  .docs[index]
                                                              ["joinDay"],
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            MColors.black,
                                                        backgroundColor:
                                                            Colors.yellow[600],
                                                        minimumSize: const Size
                                                            .fromHeight(
                                                          50,
                                                        ),
                                                      ),
                                                      child: const Text("Sửa"),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async =>
                                                          await showCautionDialog(
                                                        shipperSnap.data!
                                                                .docs[index]
                                                            ["email"],
                                                        shipperSnap.data!
                                                                .docs[index]
                                                            ["fullName"],
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            MColors.white,
                                                        backgroundColor:
                                                            Colors.red[600],
                                                        minimumSize: const Size
                                                            .fromHeight(
                                                          50,
                                                        ),
                                                      ),
                                                      child: const Text("Xóa"),
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
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("Đang tải"));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formAddShipper() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: MColors.darkBlue3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 1000,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Họ tên:",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: fullName,
                              maxLength: 100,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hoverColor: Pastel.blue,
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MColors.darkBlue),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hãy nhập họ tên";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "CCCD:",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: cccd,
                              maxLength: 12,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hoverColor: Pastel.blue,
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MColors.darkBlue),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hãy nhập CCCD";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ngày sinh:",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: dayOfBirth,
                              maxLength: 10,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hoverColor: Pastel.blue,
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MColors.darkBlue),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hãy nhập ngày sinh";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Giới tính:",
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(width: 10),
                          genderChoice("Nam", 1),
                          genderChoice("Nữ", 2),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Điện thoại:",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneNumber,
                              maxLength: 10,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hoverColor: Pastel.blue,
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MColors.darkBlue),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hãy nhập số điện thoại";
                                }
                                if (!value.startsWith("0")) {
                                  return "Số điện thoại không hợp lệ";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email:",
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: email,
                              maxLength: 80,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hoverColor: Pastel.blue,
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: MColors.darkBlue),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: MColors.error),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hãy nhập email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thường trú:",
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: mainAddress,
                          maxLength: 150,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hoverColor: Pastel.blue,
                            counterText: "",
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: MColors.darkBlue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: MColors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: MColors.error),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: MColors.error),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Hãy nhập địa chỉ thường trú";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tạm trú:",
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(width: 35),
                      Expanded(
                        child: SizedBox(
                          child: TextFormField(
                            controller: secondAddress,
                            maxLength: 150,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hoverColor: Pastel.blue,
                              counterText: "",
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: MColors.darkBlue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: MColors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: MColors.error),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: MColors.error),
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Hãy nhập địa chỉ tạm trú";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 450,
                        child: Row(
                          children: [
                            const Text(
                              "Mật khẩu:",
                              style: TextStyle(fontSize: 17),
                            ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: password,
                                maxLength: 10,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hoverColor: Pastel.blue,
                                  counterText: "",
                                  hintText: "8 - 10 ký tự",
                                  hintStyle: const TextStyle(
                                    fontSize: 17,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MColors.darkBlue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: MColors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: MColors.error),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: MColors.error),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Hãy nhập mật khẩu mẫu";
                                  }
                                  if (value.length < 8) {
                                    return "Mật khẩu phải từ 8 ký tự";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MColors.darkBlue3,
                        foregroundColor: MColors.white,
                        minimumSize: const Size.fromHeight(55)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text.trim(),
                                  password: password.text.trim());
                          await addShipperData(email.text.trim());

                          resetTextController();
                          setState(() {
                            hideFunction = true;
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                    },
                    child: const Text("Thêm nhân viên"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget genderChoice(String content, int choiceIndex) {
    return SizedBox(
      width: 150,
      child: ListTile(
        title: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        leading: Radio(
          value: choiceIndex,
          groupValue: choice,
          activeColor: MColors.darkBlue3,
          onChanged: (value) {
            setState(() {
              choice = choiceIndex;
              gender = content;
            });
          },
        ),
      ),
    );
  }

  Future<void> showCautionDialog(String id, String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/caution.png",
                    color: MColors.error,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Bạn có chắc muốn xóa nhân viên $name?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MColors.white,
                      backgroundColor: MColors.black,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async => await FirebaseFirestore.instance
                        .collection("Shippers")
                        .doc(id)
                        .update({
                      "postOffice": "",
                    }),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MColors.white,
                      backgroundColor: MColors.error,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      "Đồng ý",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
