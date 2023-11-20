import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatelessWidget {
  const MyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
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
                BarChartRodData(toY: 55, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 49, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: 64, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(toY: 72, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(toY: 57, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(toY: 44, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 7, barRods: [
                BarChartRodData(toY: 88, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 8, barRods: [
                BarChartRodData(toY: 77, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 9, barRods: [
                BarChartRodData(toY: 69, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 10, barRods: [
                BarChartRodData(toY: 71, width: 15, color: Colors.amber),
              ]),
              BarChartGroupData(x: 11, barRods: [
                BarChartRodData(toY: 58, width: 15, color: Colors.teal),
              ]),
              BarChartGroupData(x: 12, barRods: [
                BarChartRodData(toY: 0, width: 15, color: Colors.amber),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
