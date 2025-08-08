import 'dart:convert';

import 'package:covid_19_app/ApiModels/Api_Responce.dart';
import 'package:covid_19_app/ApiModels/Models.dart';
import 'package:covid_19_app/view/Countries_data.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class specificCountry_Status extends StatefulWidget {
  specificCountry_Status({
    required this.countryName,
    required this.image,
    required this.totalcases,
    required this.totalDeath,
    required this.totalRecovery,
    required this.todaysCases,
  });
  String countryName;
  String image;
  int totalcases, totalDeath, totalRecovery, todaysCases;
  @override
  State<specificCountry_Status> createState() => _specificCountry_StatusState();
}

class _specificCountry_StatusState extends State<specificCountry_Status>
    with TickerProviderStateMixin {
  @override
  late final _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..forward();

  @override
  final colorList = [Colors.blue, Colors.green, Colors.red];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.countryName),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: Image.network(widget.image),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                child: PieChart(
                  dataMap: {
                    "Total Cases": widget.totalcases.toDouble(),
                    "Recovered": widget.totalRecovery.toDouble(),
                    "Deaths": widget.totalDeath.toDouble(),
                  },
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  colorList: colorList,
                  animationDuration: Duration(seconds: 2),
                  legendOptions: LegendOptions(
                    legendPosition: LegendPosition.right,
                  ),
                  chartType: ChartType.ring,
                ),
              ),

              card(
                title: "Total Cases: ${widget.totalcases}",
                context: context,
              ),
              Divider(),
              card(
                title: "Total Recovery: ${widget.totalRecovery ?? 0}",
                context: context,
              ),
              Divider(),
              card(
                title: "Total Deaths: ${widget.totalDeath}",
                context: context,
              ),
              Divider(),
              card(
                title: "Total Deaths: ${widget.totalcases}",
                context: context,
              ),
              Divider(),
              card(
                title: "Total Deaths: ${widget.todaysCases}",
                context: context,
              ),
              SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }
}

// costimized card widget
Widget card({title, context}) {
  return Padding(
    padding: EdgeInsets.all(9.0),
    child: Card(
      child: Center(
        child: Text(title, style: TextTheme.of(context).headlineMedium),
      ),
    ),
  );
}
