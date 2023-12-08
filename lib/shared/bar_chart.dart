import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  List<String> list = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var t = await FirebaseFirestore.instance
        .collection("PostOffice")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    setState(() {
      list = List.from(t["donHang"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
              border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              ),
            ),
            groupsSpace: 10,
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(toY: 5, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 9, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: 6, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(toY: 7, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(toY: 5, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(toY: 4, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 7, barRods: [
                BarChartRodData(toY: 8, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 8, barRods: [
                BarChartRodData(toY: 7, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 9, barRods: [
                BarChartRodData(toY: 9, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 10, barRods: [
                BarChartRodData(toY: 5, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 11, barRods: [
                BarChartRodData(toY: 3, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 12, barRods: [
                BarChartRodData(
                    toY: double.parse(list.length.toString()),
                    width: 15,
                    color: Colors.teal),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
