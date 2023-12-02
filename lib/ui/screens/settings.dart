import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:gogo_admin/ui/screens/auth/login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static bool notificationON = true;
  static bool autoUpdate = true;
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    getUserSettings();
    super.initState();
  }

  getUserSettings() async {
    var t = await FirebaseFirestore.instance
        .collection("PostOffice")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    setState(() {
      SettingsScreen.notificationON = t["batThongBao"];
      SettingsScreen.autoUpdate = t["isAutoUpdate"];
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false);
      }
    }
  }

  Future<void> showAlertDialog() async {
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
                    color: MColors.darkBlue,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Bạn muốn đăng xuất?",
                      style: TextStyle(
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MColors.darkBlue,
                      backgroundColor: MColors.white,
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async => await logout(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MColors.white,
                      backgroundColor: MColors.darkBlue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("PostOffice")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Thông tin bưu cục",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // width: 700,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data!["anhDaiDien"]
                                              .toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data!["tenBuuCuc"]}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Email: ${snapshot.data!["email"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Điện thoại: ${snapshot.data!["soDT"]}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Địa chỉ: ${snapshot.data!["dcBuuCuc"]}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Cài đặt",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    notificationSwitch(),
                    const SizedBox(
                      height: 10,
                    ),
                    autoUpdateSwitch(),
                    const SizedBox(
                      height: 10,
                    ),
                    logOutButton(),
                  ],
                );
              } else {
                return const Center(
                  child: Text("error"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget notificationSwitch() {
    return GestureDetector(
      onTap: () => setState(() {
        SettingsScreen.notificationON = !SettingsScreen.notificationON;
      }),
      child: Container(
        height: 45,
        // width: 700,
        decoration: BoxDecoration(
          color: MColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Thông báo",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Switch(
                  onChanged: (value) async => {
                    await FirebaseFirestore.instance
                        .collection("PostOffice")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .update({
                      "batThongBao": value,
                    }),
                    setState(() {
                      SettingsScreen.notificationON = value;
                    }),
                  },
                  value: SettingsScreen.notificationON,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                  trackOutlineColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget autoUpdateSwitch() {
    return GestureDetector(
      onTap: () => setState(() {
        SettingsScreen.autoUpdate = !SettingsScreen.autoUpdate;
      }),
      child: Container(
        height: 45,
        // width: 700,
        decoration: BoxDecoration(
          color: MColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Tự động cập nhật",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Expanded(child: SizedBox()),
              Switch(
                onChanged: (value) async => {
                  await FirebaseFirestore.instance
                      .collection("PostOffice")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .update({
                    "isAutoUpdate": value,
                  }),
                  setState(() {
                    SettingsScreen.autoUpdate = value;
                  }),
                },
                value: SettingsScreen.autoUpdate,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                trackOutlineColor:
                    const MaterialStatePropertyAll(Colors.transparent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logOutButton() {
    return GestureDetector(
      onTap: () => showAlertDialog(),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: MColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Đăng xuất",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
