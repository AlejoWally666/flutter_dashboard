import 'package:flowkit/controller/apps/project/project_detail_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/images.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flowkit/helpers/widgets/controller_builder.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  ProjectDetailController controller = ProjectDetailController();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: ControllerBuilder(
        init: controller,
        tag: 'project_detail_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Project",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Project Detail'),
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
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "Total Task", "234", "This Month", "2.48%")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "End Date", "18/04/24", "Complete", "73.39%")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "Hours Spent", "271h 30m", "Status", "53.67%")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "Team Members", "734", "Leads", "2.57%")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "Due Tasks", "182", "Incomplete", "4.46%")),
                    MyFlexItem(
                        sizes: 'xl-2 lg-2 md-4 sm-6 xs-12',
                        child: projectDetail(
                            "Productivity", "83%", "Increase", "4.78%")),
                    MyFlexItem(sizes: 'xl-7 lg-7 md-6', child: aboutProject()),
                    MyFlexItem(
                        sizes: 'xl-5 lg-5 md-6', child: projectActivity()),
                    MyFlexItem(sizes: 'xl-8 lg-8 md-6', child: project()),
                    MyFlexItem(sizes: 'xl-4 lg-4 md-6', child: attachments()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget attachments() {
    Widget attachmentData(IconData icon, String fileName, String fileSize) {
      return MyContainer(
        color: contentTheme.primary.withValues(alpha: .15),
        borderRadiusAll: 8,
        child: Row(
          children: [
            Icon(icon, color: contentTheme.primary),
            MySpacing.width(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(fileName,
                      fontWeight: 600,
                      color: contentTheme.primary,
                      overflow: TextOverflow.ellipsis),
                  MyText.bodyMedium(fileSize,
                      fontWeight: 600, color: contentTheme.primary),
                ],
              ),
            ),
            Icon(LucideIcons.download, color: contentTheme.primary),
          ],
        ),
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Attachments", fontWeight: 600),
          MySpacing.height(20),
          attachmentData(LucideIcons.file_audio, 'songs.mp3', '373MB'),
          MySpacing.height(16),
          attachmentData(LucideIcons.file_video, 'video.mp4', '533MB'),
          MySpacing.height(16),
          attachmentData(LucideIcons.file_archive, 'fileName', '3.3MB'),
          MySpacing.height(16),
          attachmentData(LucideIcons.file_warning, 'internal.zip', '1.3GB'),
          MySpacing.height(16),
          attachmentData(LucideIcons.file_audio, 'audio', '33MB'),
        ],
      ),
    );
  }

  Widget project() {
    return MyContainer(
      borderRadiusAll: 8,
      padding: MySpacing.fromLTRB(16, 24, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Project OverView", fontWeight: 600),
          MySpacing.height(16),
          SizedBox(
            height: 414,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap),
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 1,
                  majorGridLines: MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}%', axisLine: AxisLine(width: 0)),
              series: controller.projectOverView(),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          )
        ],
      ),
    );
  }

  Widget aboutProject() {
    return MyContainer(
      borderRadiusAll: 8,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("About Project", fontWeight: 600),
          MySpacing.height(16),
          MyText.bodySmall(controller.dummyTexts[1],
              maxLines: 3, fontWeight: 600, muted: true),
          MySpacing.height(16),
          MyText.bodySmall(controller.dummyTexts[2],
              maxLines: 3, fontWeight: 600, muted: true),
          MySpacing.height(16),
          Row(
            children: [
              MyContainer.rounded(color: contentTheme.dark, paddingAll: 3),
              MySpacing.width(12),
              Expanded(
                  child: MyText.bodyMedium("Quits after vel eum ire",
                      fontWeight: 600, overflow: TextOverflow.ellipsis))
            ],
          ),
          MySpacing.height(12),
          Row(
            children: [
              MyContainer.rounded(color: contentTheme.dark, paddingAll: 3),
              MySpacing.width(12),
              Expanded(
                  child: MyText.bodyMedium("Ut enim ad minima veniam",
                      fontWeight: 600, overflow: TextOverflow.ellipsis)),
            ],
          ),
          MySpacing.height(12),
          Row(
            children: [
              MyContainer.rounded(color: contentTheme.dark, paddingAll: 3),
              MySpacing.width(12),
              Expanded(
                  child: MyText.bodyMedium("Nam libero cum soluta",
                      fontWeight: 600, overflow: TextOverflow.ellipsis))
            ],
          ),
          MySpacing.height(16),
          MyText.titleMedium("Tags", fontWeight: 600),
          MySpacing.height(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: controller.tags
                .map(
                  (tag) => MyContainer(
                    paddingAll: 4,
                    color: contentTheme.primary.withValues(alpha: .2),
                    child: MyText.bodySmall(tag,
                        fontWeight: 700, color: contentTheme.primary),
                  ),
                )
                .toList(),
          ),
          MySpacing.height(16),
          MyText.titleMedium("Team Members:", fontWeight: 600),
          MySpacing.height(16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.teamMember
                .map(
                  (member) => MyContainer.roundBordered(
                    paddingAll: 4,
                    child: MyContainer.rounded(
                      paddingAll: 0,
                      height: 32,
                      width: 32,
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(member, fit: BoxFit.cover),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget projectActivity() {
    return MyContainer(
      borderRadiusAll: 8,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Project Activities", fontWeight: 600),
          MySpacing.height(16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: controller.projectActivities.length,
            itemBuilder: (context, index) {
              var activities = controller.projectActivities[index];
              return Row(
                children: [
                  MyContainer.rounded(
                    height: 40,
                    width: 40,
                    paddingAll: 0,
                    child: Image.asset(
                        Images.avatars[index % Images.avatars.length],
                        fit: BoxFit.cover),
                  ),
                  MySpacing.width(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.bodyMedium(activities['name'],
                            fontWeight: 600, overflow: TextOverflow.ellipsis),
                        MySpacing.height(4),
                        MyText.bodySmall(activities['email'],
                            fontWeight: 600, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  MyContainer(
                    paddingAll: 4,
                    color: contentTheme.primary.withValues(alpha: .2),
                    child: MyText.bodySmall(activities['work'],
                        fontWeight: 600, color: contentTheme.primary),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return MySpacing.height(24);
            },
          )
        ],
      ),
    );
  }

  Widget projectDetail(
      String title, String detail, String projectStatus, String projectRate) {
    return MyContainer(
      borderRadiusAll: 8,
      height: 150,
      paddingAll: 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.labelLarge(title,
              fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis),
          MyText.titleLarge(detail,
              fontWeight: 700,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MyText.bodyMedium(projectStatus,
                      fontWeight: 600,
                      muted: true,
                      overflow: TextOverflow.ellipsis)),
              MyText.bodyMedium(projectRate, fontWeight: 600, muted: true),
            ],
          )
        ],
      ),
    );
  }
}