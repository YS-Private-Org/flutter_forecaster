import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forecaster/flutter_forecaster.dart';
import 'package:intl/intl.dart';

void main() {
  RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<PredictionSource> sourceList = [
    PredictionSource(date: DateTime(2022, 3, 1), value: 53795.20),
    PredictionSource(date: DateTime(2022, 4, 1), value: 58202.80),
    PredictionSource(date: DateTime(2022, 5, 1), value: 120249.00),
    PredictionSource(date: DateTime(2022, 6, 1), value: 97371.00),
    PredictionSource(date: DateTime(2022, 7, 1), value: 97554.80),
    PredictionSource(date: DateTime(2022, 8, 1), value: 65275.20),
    PredictionSource(date: DateTime(2022, 9, 1), value: 71966.10),
    PredictionSource(date: DateTime(2022, 10, 1), value: 94226.00),
    PredictionSource(date: DateTime(2022, 11, 1), value: 92632.80),
    PredictionSource(date: DateTime(2022, 12, 1), value: 101575.00),
    PredictionSource(date: DateTime(2023, 1, 1), value: 102551.00),
    PredictionSource(date: DateTime(2023, 2, 1), value: 91036.80),
    PredictionSource(date: DateTime(2023, 3, 1), value: 79047.20),
    PredictionSource(date: DateTime(2023, 4, 1), value: 92570.00),
    PredictionSource(date: DateTime(2023, 5, 1), value: 96528.20),
    PredictionSource(date: DateTime(2023, 6, 1), value: 116322.20),
    PredictionSource(date: DateTime(2023, 7, 1), value: 84685.00),
    PredictionSource(date: DateTime(2023, 8, 1), value: 107269.00),
    PredictionSource(date: DateTime(2023, 9, 1), value: 78098.40),
    PredictionSource(date: DateTime(2023, 10, 1), value: 103124.60),
    PredictionSource(date: DateTime(2023, 11, 1), value: 152036.40),
    PredictionSource(date: DateTime(2023, 12, 1), value: 117605.80),
    PredictionSource(date: DateTime(2024, 1, 1), value: 200878.55),
    PredictionSource(date: DateTime(2024, 2, 1), value: 103947.00),
    PredictionSource(date: DateTime(2024, 3, 1), value: 109980.60),
    PredictionSource(date: DateTime(2024, 4, 1), value: 126572.90),
    PredictionSource(date: DateTime(2024, 5, 1), value: 121192.10),
    PredictionSource(date: DateTime(2024, 6, 1), value: 113852.00),
    PredictionSource(date: DateTime(2024, 7, 1), value: 145274.80),
    PredictionSource(date: DateTime(2024, 8, 1), value: 198366.05),
    PredictionSource(date: DateTime(2024, 9, 1), value: 118818.90),
    PredictionSource(date: DateTime(2024, 10, 1), value: 110186.00),
    PredictionSource(date: DateTime(2024, 11, 1), value: 111488.64),
    PredictionSource(date: DateTime(2024, 12, 1), value: 81678.44),
    PredictionSource(date: DateTime(2025, 1, 1), value: 106418.20),
    PredictionSource(date: DateTime(2025, 2, 1), value: 84354.40),
  ];

  List<PredictionSource> predictedList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  child: Text('ARIMA'),
                  onPressed: () async {
                    predictedList = await ArimaForecaster()
                        .initializePrediction(sourceData: sourceList);
                    setState(() {});
                  },
                ),
                const SizedBox(width: 10),
                CupertinoButton(
                  child: Text('AUGUR MSTL'),
                  onPressed: () async {
                    predictedList = await AugurForecaster()
                        .initializePrediction(sourceData: sourceList);
                    setState(() {});
                  },
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  buildDataList(sourceList, 'Source Data'),
                  buildDataList(predictedList, 'Predicted Data'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataList(List<PredictionSource> sourceList, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Expanded(
            child: ListView.builder(
              itemCount: sourceList.length,
              itemBuilder: (context, index) {
                final source = sourceList[index];
                return Text(
                  '${DateFormat('MMMM yyyy').format(source.date)}: ${source.value.toStringAsFixed(2)}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
