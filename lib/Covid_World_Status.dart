import 'dart:convert';

import 'package:covid_19_app/ApiModels/Api_Responce.dart';
import 'package:covid_19_app/ApiModels/Models.dart';
import 'package:covid_19_app/view/Countries_data.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
class OverAll_Status extends StatefulWidget {
  const OverAll_Status({super.key});

  @override
  State<OverAll_Status> createState() => _OverAll_StatusState();
}

class _OverAll_StatusState extends State<OverAll_Status>with TickerProviderStateMixin {

ApiResponce api_call = ApiResponce();
  @override
  late final  _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..forward();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<CovidData> (
              future:  api_call.fetchCovidData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6, // gives vertical space
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6, // gives vertical space
                    child: Center(
                      child: Text("No data available"),
                    ),
                  );
                }
                final covid = snapshot.data!;
                final pieData = {
                  "Total Cases": covid.cases?.toDouble() ?? 0,
                  "Recovered": covid.recovered?.toDouble() ?? 0,
                  "Deaths": covid.deaths?.toDouble() ?? 0,
                };
            
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *0.3 ,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PieChart(

                        dataMap: pieData,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        colorList: colorList,
                        animationDuration: Duration(seconds: 2),
                        legendOptions: LegendOptions(legendPosition: LegendPosition.right),
                        chartType: ChartType.ring,
                      ),
                    ),
            
                    card(title: "Total Cases: ${covid.cases ?? 0}", context: context),
                    Divider(),
                    card(title: "Total Recovery: ${covid.recovered ?? 0}", context: context),
                    Divider(),
                    card(title: "Total Deaths: ${covid.deaths ?? 0}", context: context),
                    Divider(),
                    card(title: "Total Deaths: ${covid.todayCases ?? 0}", context: context),
                    Divider(),
                    card(title: "Total Deaths: ${covid.todayDeaths ?? 0}", context: context),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Covid_Countries_Data()));
                    },
                        child: Text("Search Country"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.black
                    ),
                    )

                  ],
                );
              },
                      )
            
            
            
            
                ],
              ),
            ),
          )),
    );
  }
}

// costimized card widget
Widget card({title, context}){
  return Padding(
    padding:  EdgeInsets.all(9.0),
    child: Card(

      child: Center(
        child: Text(title,style: TextTheme.of(context).headlineMedium,),
      ),
    ),
  );
}