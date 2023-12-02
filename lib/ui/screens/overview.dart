import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/bar_chart.dart';
import 'package:gogo_admin/shared/mcolors.dart';
import 'package:pie_chart/pie_chart.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  String thisMonth = "";
  List<String> delivering = [];
  List<String> delay = [];
  List<String> delivered = [];

  List<String> picking = [];
  List<String> delayPick = [];
  List<String> successPick = [];

  void getChartData() async {
    var deliveringQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Đang giao hàng")
        .get();
    var deliveringL =
        deliveringQ.docs.map((order) => order.toString()).toList();

    var delayQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Delay giao hàng")
        .get();
    var delayL = delayQ.docs.map((order) => order.toString()).toList();

    var deliveredQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Đã giao hàng")
        .get();
    var deliveredL = deliveredQ.docs.map((order) => order.toString()).toList();

    var pickingQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Đang lấy hàng")
        .get();
    var pickingL = pickingQ.docs.map((order) => order.toString()).toList();

    var delayPickQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Delay lấy hàng")
        .get();
    var delayPickL = delayPickQ.docs.map((order) => order.toString()).toList();

    var successPQ = await FirebaseFirestore.instance
        .collection("DeliverOrders")
        .where("trangThaiDonHang", isEqualTo: "Đã lấy hàng")
        .get();
    var sucessPL = successPQ.docs.map((order) => order.toString()).toList();

    setState(() {
      delivering = deliveringL;
      delay = delayL;
      delivered = deliveredL;

      picking = pickingL;
      delayPick = delayPickL;
      successPick = sucessPL;

      giaoHang.update("Đang giao hàng",
          (value) => value = double.parse(delivering.length.toString()));
      giaoHang.update("Delay giao hàng",
          (value) => value = double.parse(delay.length.toString()));
      giaoHang.update("Đã giao hàng",
          (value) => value = double.parse(delivered.length.toString()));

      layHang.update("Đang lấy hàng",
          (value) => value = double.parse(picking.length.toString()));
      layHang.update("Delay lấy hàng",
          (value) => value = double.parse(delayPick.length.toString()));
      layHang.update("Đã lấy hàng",
          (value) => value = double.parse(successPick.length.toString()));
    });
  }

  Map<String, double> giaoHang = {
    "Đang giao hàng": 0,
    "Delay giao hàng": 0,
    "Đã giao hàng": 0,
  };
  Map<String, double> layHang = {
    "Đang lấy hàng": 0,
    "Delay lấy hàng": 0,
    "Đã lấy hàng": 0,
  };

  @override
  void initState() {
    getChartData();
    var t = DateTime.now();
    setState(() {
      thisMonth = "${t.month}";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tình trạng đơn hàng tháng $thisMonth",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            child: PieChart(
                              dataMap: giaoHang,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius: 150,
                              colorList: const [
                                MColors.darkBlue3,
                                MColors.lightBlue2,
                                MColors.darkBlue,
                              ],
                              initialAngleInDegree: 180,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 30,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Đơn hàng giao",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            child: PieChart(
                              dataMap: layHang,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius: 150,
                              colorList: const [
                                MColors.lightBlue3,
                                MColors.lightPink2,
                                MColors.lightPurple,
                              ],
                              initialAngleInDegree: 180,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 30,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Đơn hàng lấy",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Đơn hàng đã giao trong năm",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            "Số đơn hàng mỗi tháng",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 55,
                        child: MyBarChart(),
                      ),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tháng trong năm",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
