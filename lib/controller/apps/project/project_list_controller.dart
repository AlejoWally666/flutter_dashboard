import 'package:flowkit/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectListController extends MyController {
  double findAspectRatio() {
    var width = MediaQuery.of(Get.context!).size.width;
    var extraSpacing = 68;
    var gridCount = 4;
    var fixHeight = 258;
    return ((width - extraSpacing) / gridCount) / fixHeight;
  }

  List projectList = [
    {
      "id": 1,
      "title": "New Admin Design",
      "company_name": "Orange Limited",
      "status": "Finished",
      "shortDesc":
          "With supporting text below as a natural lead-in to additional content.",
      "totalTasks": 78,
      "totalComments": 214,
      "progress": .36
    },
    {
      "id": 2,
      "title": "App Design and Development",
      "company_name": "Moon dust Software's",
      "status": "Ongoing",
      "shortDesc":
          "A handful of model sentence structures to generate Lorem Ipsum that looks reasonable.",
      "totalTasks": 85,
      "totalComments": 103,
      "progress": .15
    },
    {
      "id": 3,
      "title": "Landing Page Design",
      "company_name": "Rose Technologies",
      "status": "Finished",
      "shortDesc":
          "Ensure there isn't anything embarrassing hidden in the middle of the text.",
      "totalTasks": 42,
      "totalComments": 65,
      "progress": .55
    },
    {
      "id": 4,
      "title": "Custom Software Development",
      "company_name": "Apple Navigation",
      "status": "Ongoing",
      "shortDesc":
          "Ensure there isn't anything embarrassing hidden in the middle of the text.",
      "totalTasks": 95,
      "totalComments": 83,
      "progress": .72
    },
    {
      "id": 5,
      "title": "Website Redesign",
      "company_name": "Enigma Navigation",
      "status": "Ongoing",
      "shortDesc":
          "There are many variations of passages of Lorem Ipsum available for natural lead-in to additional content.",
      "totalTasks": 36,
      "totalComments": 78,
      "progress": .38
    },
    {
      "id": 6,
      "title": "Multipurpose Landing Template",
      "company_name": "Pride Software's",
      "status": "Finished",
      "shortDesc":
          "With supporting text below as a natural lead-in to additional content.",
      "totalTasks": 30,
      "totalComments": 148,
      "progress": .47
    }
  ];

  void goToCreateProject() {
    Get.offNamed('/app/project/create_project');
  }
}
