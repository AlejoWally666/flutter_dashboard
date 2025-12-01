import 'package:file_picker/file_picker.dart';
import 'package:flowkit/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProjectPrivacy {
  private,
  team,
  public;

  const ProjectPrivacy();
}

class CreateProjectController extends MyController {
  ProjectPrivacy selectProjectPrivacy = ProjectPrivacy.private;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  List<PlatformFile> files = [];
  String selectProperties = "Medium";

  Future<void> pickFile() async {
    var result = await FilePicker.platform.pickFiles();
    if (result?.files[0] != null) files.add(result!.files[0]);
    update();
  }

  Future<void> pickStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedStartDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      selectedStartDate = picked;
      update();
    }
  }

  Future<void> pickEndDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedEndDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      selectedEndDate = picked;
      update();
    }
  }

  void onSelectedSize(String size) {
    selectProperties = size;
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    update();
  }

  void onChangeProjectPrivacy(ProjectPrivacy? value) {
    selectProjectPrivacy = value ?? selectProjectPrivacy;
    update();
  }
}
