import 'package:flowkit/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HospitalController extends MyController {
  TooltipBehavior? tooltipBehavior;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true, format: 'point.x');
    super.onInit();
  }

  List<RadialBarSeries<ChartSampleData, String>>
      hospitalBirthAndDeathAnalytics() {
    final List<RadialBarSeries<ChartSampleData, String>> list =
        <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
          animationDuration: 0,
          maximumValue: 100,
          radius: '100%',
          gap: '10%',
          innerRadius: '60%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'Birth Case', y: 65, pointColor: Colors.green),
            ChartSampleData(
                x: 'Accident Case', y: 43, pointColor: Colors.orange),
            ChartSampleData(x: 'Death Case', y: 58, pointColor: Colors.red),
          ],
          cornerStyle: CornerStyle.endCurve,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(isVisible: true))
    ];
    return list;
  }

  List newPatientData = [
    {
      "id": 1,
      "patient_name": "Elli Paton",
      "gender": "Male",
      "doctor_name": "Cherye",
      "date": "08/06/2023",
      "time": "08/30/2023"
    },
    {
      "id": 2,
      "patient_name": "Amerigo",
      "gender": "Female",
      "doctor_name": "Manon",
      "date": "02/18/2024",
      "time": "05/06/2024"
    },
    {
      "id": 3,
      "patient_name": "Pail",
      "gender": "Male",
      "doctor_name": "Aldus",
      "date": "07/27/2024",
      "time": "07/17/2024"
    },
    {
      "id": 4,
      "patient_name": "Sibylla",
      "gender": "Male",
      "doctor_name": "Enrika",
      "date": "01/16/2024",
      "time": "10/13/2023"
    },
    {
      "id": 5,
      "patient_name": "Sisile Duran",
      "gender": "Female",
      "doctor_name": "Tomasine",
      "date": "04/05/2024",
      "time": "12/14/2023"
    }
  ];
}

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}
