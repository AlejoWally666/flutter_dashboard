import 'package:flowkit/controller/apps/project/project_list_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_progress_bar.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  ProjectListController controller = Get.put(ProjectListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'project_list_controller',
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
                        MyBreadcrumbItem(name: 'Project List'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer(
                      onTap: () => controller.goToCreateProject(),
                      borderRadiusAll: 8,
                      paddingAll: 12,
                      color: contentTheme.primary,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.plus,
                              size: 20, color: contentTheme.onPrimary),
                          MySpacing.width(8),
                          MyText.bodyMedium("Create Project",
                              fontWeight: 600, color: contentTheme.onPrimary),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          mainAxisExtent: 300),
                      itemCount: controller.projectList.length,
                      itemBuilder: (context, index) {
                        dynamic project = controller.projectList[index];
                        return MyContainer(
                          paddingAll: 24,
                          borderRadiusAll: 8,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.bodyMedium(project['title'],
                                  fontWeight: 600),
                              MySpacing.height(12),
                              MyContainer(
                                paddingAll: 4,
                                color: project['status'] == 'Finished'
                                    ? contentTheme.primary
                                    : contentTheme.secondary,
                                child: MyText.bodySmall(project['status'],
                                    fontWeight: 600,
                                    color: contentTheme.onPrimary),
                              ),
                              MySpacing.height(12),
                              MyText.titleMedium(project['company_name'],
                                  fontWeight: 700, muted: true),
                              MySpacing.height(12),
                              MyText.bodySmall(project['shortDesc'],
                                  fontWeight: 600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              MySpacing.height(12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(LucideIcons.logs, size: 18),
                                  MySpacing.width(8),
                                  MyText.bodyMedium(
                                      "${project['totalTasks']} Task",
                                      fontWeight: 600),
                                ],
                              ),
                              MySpacing.height(12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(LucideIcons.message_square_text,
                                      size: 18),
                                  MySpacing.width(8),
                                  MyText.bodyMedium(
                                      "${project['totalComments']} Comments",
                                      fontWeight: 600),
                                ],
                              ),
                              MySpacing.height(12),
                              MyText.titleMedium("Task Complete",
                                  fontWeight: 600),
                              MySpacing.height(8),
                              MyProgressBar(
                                  height: 6,
                                  width: 400,
                                  activeColor: contentTheme.primary,
                                  inactiveColor:
                                      contentTheme.secondary.withValues(alpha: .4),
                                  progress: project['progress'])
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
