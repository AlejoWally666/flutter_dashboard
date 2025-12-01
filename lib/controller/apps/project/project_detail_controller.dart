import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_text_utils.dart';
import 'package:flowkit/images.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectDetailController extends MyController {
  List<ChartData>? chartData;

  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    chartData = <ChartData>[
      ChartData(2005, 21, 28),
      ChartData(2006, 24, 44),
      ChartData(2007, 36, 48),
      ChartData(2008, 38, 50),
      ChartData(2009, 54, 66),
      ChartData(2010, 57, 78),
      ChartData(2011, 70, 84)
    ];
    super.onInit();
  }

  List<String> tags = ["HTML", "CSS", "Tailwind", "JAVAScript"];

  List<String> teamMember = [
    Images.avatars[0],
    Images.avatars[1],
    Images.avatars[2],
    Images.avatars[3],
    Images.avatars[4],
  ];

  List projectActivities = [
    {"name": "Jenna", "email": "janthes0@google.com.br", "work": "Wire Frame"},
    {"name": "Noemi", "email": "npeare1@marriott.com", "work": "Figma Design"},
    {"name": "Nan", "email": "nvaudre2@godaddy.com", "work": "Frontend"},
    {"name": "Verile", "email": "vpaulack3@indiatimes.com", "work": "Backend"},
    {
      "name": "Devinne",
      "email": "dplaschke4@businesswire.com",
      "work": "Support"
    },
    {"name": "Katinka", "email": "kocrotty5@bloglovin.com", "work": "Testing"},
  ];

  List<LineSeries<ChartData, num>> projectOverView() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          name: 'Design',
          markerSettings: MarkerSettings(isVisible: true)),
      LineSeries<ChartData, num>(
          dataSource: chartData,
          name: 'Development',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y2,
          markerSettings: MarkerSettings(isVisible: true))
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
