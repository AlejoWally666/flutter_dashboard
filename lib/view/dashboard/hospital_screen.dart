import 'package:flowkit/controller/dashboard/hospital_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_list_extension.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/images.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flowkit/helpers/widgets/controller_builder.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> with UIMixin {
  HospitalController controller = HospitalController();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: ControllerBuilder(
        init: controller,
        tag: 'hospital_dashboard_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Dashboard",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Hospital'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                        sizes: 'xl-3 lg-6 md-6 sm-6 xs-12',
                        child: hospitalOverView(
                            LucideIcons.user,
                            "100",
                            "Doctor",
                            contentTheme.primary,
                            "5",
                            "Doctors Joined this week")),
                    MyFlexItem(
                        sizes: 'xl-3 lg-6 md-6 sm-6 xs-12',
                        child: hospitalOverView(
                            LucideIcons.users,
                            "107",
                            "Staff",
                            contentTheme.warning,
                            "7",
                            "Staff on vacation")),
                    MyFlexItem(
                        sizes: 'xl-3 lg-6 md-6 sm-6 xs-12',
                        child: hospitalOverView(
                            LucideIcons.file_diff,
                            "38947",
                            "Patient",
                            contentTheme.success,
                            "279",
                            "New patient admitted")),
                    MyFlexItem(
                        sizes: 'xl-3 lg-6 md-6 sm-6 xs-12',
                        child: hospitalOverView(
                            LucideIcons.syringe,
                            "18",
                            "Pharmacies",
                            contentTheme.info,
                            "28K",
                            "Medicine on reserved")),
                    MyFlexItem(
                        sizes: 'xl-4 lg-6 md-6 sm-6 xs-12',
                        child: hospitalBirthAndDeathAnalytics()),
                    MyFlexItem(
                        sizes: 'xl-4 lg-6 md-6 sm-6 xs-12',
                        child: hospitalReport()),
                    MyFlexItem(
                        sizes: 'xl-4 lg-6 md-6 sm-6 xs-12',
                        child: doctorList()),
                    MyFlexItem(
                        sizes: 'xl-4 lg-6 md-6 sm-6 xs-12',
                        child: topDepartment()),
                    MyFlexItem(sizes: 'xl-8', child: newPatient()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget hospitalOverView(IconData icon, String title, String subTitle,
      Color color, String countData, String countDetail) {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      paddingAll: 24,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyContainer.rounded(
                paddingAll: 20,
                color: color.withValues(alpha: .2),
                child: Icon(icon, size: 28, color: color),
              ),
              MySpacing.width(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleLarge(title, fontWeight: 800, letterSpacing: .5),
                  MyText.bodyMedium(subTitle, fontWeight: 600, xMuted: true),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText.bodyMedium(countData, fontWeight: 600, color: color),
              MySpacing.width(4),
              Expanded(
                  child: MyText.bodyMedium(countDetail,
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget hospitalBirthAndDeathAnalytics() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      padding: MySpacing.fromLTRB(24, 24, 24, 16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Hospital Birth & Death Analytics",
              fontWeight: 600),
          MySpacing.height(24),
          SfCircularChart(
            legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                iconHeight: 24,
                iconWidth: 24,
                overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: controller.tooltipBehavior,
            series: controller.hospitalBirthAndDeathAnalytics(),
          )
        ],
      ),
    );
  }

  Widget hospitalReport() {
    Widget hospitalReportData(IconData icon, String title, String subTitle) {
      return MyContainer.bordered(
        borderRadiusAll: 12,
        padding: MySpacing.fromLTRB(16, 13, 16, 13),
        child: Row(
          children: [
            Icon(icon),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(title,
                      fontWeight: 600, overflow: TextOverflow.ellipsis),
                  MyText.bodySmall(subTitle, fontWeight: 600, muted: true)
                ],
              ),
            )
          ],
        ),
      );
    }

    return MyCard(
      paddingAll: 24,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: MyText.titleMedium("Hospital Report",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
              InkWell(
                  onTap: () {},
                  child: MyText.bodyMedium("View All", fontWeight: 600))
            ],
          ),
          MySpacing.height(24),
          hospitalReportData(LucideIcons.air_vent, "Room 502 Ac is not working",
              "Reported by Steve"),
          MySpacing.height(24),
          hospitalReportData(LucideIcons.calendar_days,
              "Daniel extended his holiday", "Reported by Andrew"),
          MySpacing.height(24),
          hospitalReportData(
              LucideIcons.calendar_days, "Holiday", "Reported by Andrew"),
          MySpacing.height(24),
          hospitalReportData(LucideIcons.air_vent, "Room 508 Ac is not working",
              "Reported by John")
        ],
      ),
    );
  }

  Widget doctorList() {
    Widget doctorListData(
        String image, String doctorName, String doctorSpecialize) {
      return Row(
        children: [
          MyContainer.rounded(
            height: 43,
            width: 43,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium("Dr. $doctorName", fontWeight: 600),
              MyText.bodySmall(doctorSpecialize, fontWeight: 600)
            ],
          )
        ],
      );
    }

    return MyCard(
      paddingAll: 24,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.titleMedium("Doctor List", fontWeight: 600),
              InkWell(
                  onTap: () {},
                  child: MyText.bodyMedium("View all", fontWeight: 600))
            ],
          ),
          MySpacing.height(24),
          doctorListData(Images.avatars[0], "Brandon", "Gynecologist"),
          MySpacing.height(24),
          doctorListData(Images.avatars[1], "Gregory", "Cardiologist"),
          MySpacing.height(24),
          doctorListData(Images.avatars[2], "Robert", "Histopathologic"),
          MySpacing.height(24),
          doctorListData(Images.avatars[3], "Calvin", "Neurologist"),
          MySpacing.height(24),
          doctorListData(Images.avatars[4], "Brandon", "Gynecologist"),
        ],
      ),
    );
  }

  Widget topDepartment() {
    Widget topDepartmentWidget(String title, String data) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: MyText.titleMedium(title,
                  fontWeight: 600, overflow: TextOverflow.ellipsis)),
          MyContainer.rounded(
            paddingAll: 12,
            color: contentTheme.primary.withValues(alpha: .2),
            child: MyText.bodySmall(data,
                color: contentTheme.primary, fontWeight: 600),
          )
        ],
      );
    }

    return MyCard(
      paddingAll: 24,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: MyText.titleMedium("Top Department",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
              InkWell(
                  onTap: () {},
                  child: MyText.bodyMedium("View all", fontWeight: 600))
            ],
          ),
          MySpacing.height(24),
          topDepartmentWidget("General Physician", "28%"),
          Divider(height: 29),
          topDepartmentWidget("Dentist", "16%"),
          Divider(height: 29),
          topDepartmentWidget("ENT", "17%"),
          Divider(height: 29),
          topDepartmentWidget("Cardiologist", "71%"),
          Divider(height: 29),
          topDepartmentWidget("Opthomology", "23%"),
        ],
      ),
    );
  }

  Widget newPatient() {
    Widget newPatientData() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: MyContainer.none(
          borderRadiusAll: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DataTable(
              onSelectAll: (_) => {},
              headingRowColor:
                  WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dataRowMaxHeight: 51,
              columns: [
                DataColumn(
                    label: MyText.labelLarge('Patient',
                        color: contentTheme.primary)),
                DataColumn(
                    label: MyText.labelLarge('Gender',
                        color: contentTheme.primary)),
                DataColumn(
                    label: MyText.labelLarge('Appointment for',
                        color: contentTheme.primary)),
                DataColumn(
                    label:
                        MyText.labelLarge('Date', color: contentTheme.primary)),
                DataColumn(
                    label:
                        MyText.labelLarge('Time', color: contentTheme.primary)),
              ],
              rows: controller.newPatientData
                  .mapIndexed((index, data) => DataRow(cells: [
                        DataCell(SizedBox(
                          width: 230,
                          child: Row(
                            children: [
                              MyContainer.rounded(
                                height: 40,
                                width: 40,
                                borderRadiusAll: 8,
                                paddingAll: 0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.asset(
                                    Images
                                        .avatars[index % Images.avatars.length],
                                    fit: BoxFit.cover),
                              ),
                              MySpacing.width(12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodyMedium(data['patient_name'],
                                      fontWeight: 600),
                                  MyText.bodySmall("40 Year's old",
                                      fontWeight: 600, xMuted: true)
                                ],
                              )
                            ],
                          ),
                        )),
                        DataCell(SizedBox(
                            width: 70,
                            child: MyText.bodyMedium('${data['gender']}'))),
                        DataCell(SizedBox(
                            width: 170,
                            child:
                                MyText.bodyMedium('${data['doctor_name']}'))),
                        DataCell(SizedBox(
                            width: 110,
                            child: MyText.bodyMedium("${data['date']}"))),
                        DataCell(SizedBox(
                            width: 110,
                            child: MyText.bodyMedium('${data['time']}'))),
                      ]))
                  .toList()),
        ),
      );
    }

    return MyCard(
      paddingAll: 24,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.titleMedium("New Patient", fontWeight: 600),
              InkWell(
                  onTap: () {},
                  child: MyText.bodyMedium("View all", fontWeight: 600))
            ],
          ),
          MySpacing.height(24),
          newPatientData(),
        ],
      ),
    );
  }
}