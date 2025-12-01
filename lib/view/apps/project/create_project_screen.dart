import 'package:flowkit/app_constant.dart';
import 'package:flowkit/controller/apps/project/create_project_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_dotted_line.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_list_extension.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:flowkit/helpers/widgets/controller_builder.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  CreateProjectController controller = CreateProjectController();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: ControllerBuilder(
        init: controller,
        tag: 'create_project_controller',
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
                        MyBreadcrumbItem(name: 'Create Project'),
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
                    MyFlexItem(sizes: 'lg-6', child: fieldData()),
                    MyFlexItem(sizes: 'lg-6', child: addAvatarWidget())
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget fieldData() {
    return MyContainer(
      paddingAll: 24,
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Product Data", fontWeight: 600),
          MySpacing.height(16),
          MyText.labelMedium("Project Name", fontWeight: 600),
          MySpacing.height(8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Project Name",
              hintStyle: MyTextStyle.bodyMedium(fontWeight: 600, muted: true),
              border: generateOutlineInputBorder(),
              contentPadding: MySpacing.all(16),
              isCollapsed: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          MySpacing.height(16),
          MyText.labelMedium("Project OverView", fontWeight: 600),
          MySpacing.height(8),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: "Enter Some Brief About Project",
                hintStyle: MyTextStyle.bodyMedium(fontWeight: 600, muted: true),
                border: generateOutlineInputBorder(),
                contentPadding: MySpacing.all(16),
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never),
          ),
          MySpacing.height(16),
          Wrap(
              spacing: 16,
              children: ProjectPrivacy.values
                  .map(
                    (value) => InkWell(
                      onTap: () => controller.onChangeProjectPrivacy(value),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<ProjectPrivacy>(
                              value: value,
                              activeColor: contentTheme.primary,
                              groupValue: controller.selectProjectPrivacy,
                              onChanged: controller.onChangeProjectPrivacy,
                              visualDensity: getCompactDensity,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                          MySpacing.width(8),
                          MyText.labelMedium(value.name.capitalize.toString())
                        ],
                      ),
                    ),
                  )
                  .toList()),
          MySpacing.height(16),
          MyFlex(
            contentPadding: false,
            children: [
              MyFlexItem(
                sizes: "lg-6",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelMedium("Start Date", fontWeight: 600),
                    MySpacing.height(8),
                    MyContainer.bordered(
                      paddingAll: 12,
                      borderRadiusAll: 8,
                      onTap: () => controller.pickStartDate(),
                      borderColor: theme.colorScheme.secondary,
                      border: Border.all(
                          width: 1,
                          strokeAlign: 0,
                          color: colorScheme.onSurface.withAlpha(80)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(LucideIcons.calendar,
                              color: theme.colorScheme.secondary, size: 16),
                          MySpacing.width(10),
                          MyText.bodySmall(
                              controller.selectedStartDate != null
                                  ? dateFormatter
                                      .format(controller.selectedStartDate!)
                                  : "1/10/2020",
                              fontWeight: 600),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MyFlexItem(
                sizes: "lg-6",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelMedium("End Date", fontWeight: 600),
                    MySpacing.height(8),
                    MyContainer.bordered(
                      paddingAll: 12,
                      borderRadiusAll: 8,
                      onTap: () => controller.pickEndDate(),
                      borderColor: theme.colorScheme.secondary,
                      border: Border.all(
                          width: 1,
                          strokeAlign: 0,
                          color: colorScheme.onSurface.withAlpha(80)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(LucideIcons.calendar,
                              color: theme.colorScheme.secondary, size: 16),
                          MySpacing.width(10),
                          MyText.bodySmall(
                              controller.selectedEndDate != null
                                  ? dateFormatter
                                      .format(controller.selectedEndDate!)
                                  : "1/10/2020",
                              fontWeight: 600),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          MyText.labelMedium("Project Priority", fontWeight: 600),
          MySpacing.height(8),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                "Medium",
                "High",
                "Low",
              ].map((behavior) {
                return PopupMenuItem(
                  value: behavior,
                  height: 32,
                  child: MyText.bodySmall(behavior.toString(), fontWeight: 600),
                );
              }).toList();
            },
            offset: const Offset(0, 40),
            onSelected: controller.onSelectedSize,
            color: theme.cardTheme.color,
            child: MyContainer.bordered(
              paddingAll: 12,
              borderRadiusAll: 8,
              border: Border.all(
                  width: 1,
                  strokeAlign: 0,
                  color: colorScheme.onSurface.withAlpha(80)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyText.bodyMedium(controller.selectProperties),
                  Icon(LucideIcons.chevron_down, size: 18)
                ],
              ),
            ),
          ),
          MySpacing.height(16),
          MyText.labelMedium("Budget", fontWeight: 600),
          MySpacing.height(8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Project Budget",
              hintStyle: MyTextStyle.bodyMedium(fontWeight: 600, muted: true),
              border: generateOutlineInputBorder(),
              contentPadding: MySpacing.all(16),
              isCollapsed: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          MySpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyButton(
                onPressed: () {},
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall('Create',
                    fontWeight: 600, color: contentTheme.onPrimary),
              ),
              MySpacing.width(16),
              MyButton(
                onPressed: () {},
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: contentTheme.secondary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall('Cancel',
                    fontWeight: 600, color: contentTheme.onSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addAvatarWidget() {
    return MyContainer(
      paddingAll: 24,
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Select File", fontWeight: 600),
          MySpacing.height(20),
          InkWell(
            onTap: () => controller.pickFile(),
            child: MyDottedLine(
              width: 1,
              color: colorScheme.onSurface.withAlpha(80),
              strokeWidth: 0,
              corner: MyDottedLineCorner(
                  leftBottomCorner: 8,
                  leftTopCorner: 8,
                  rightBottomCorner: 8,
                  rightTopCorner: 8),
              child: Padding(
                padding: MySpacing.xy(12, 44),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.cloud_upload),
                    MyContainer(
                      alignment: Alignment.center,
                      paddingAll: 0,
                      child: MyText.titleMedium(
                          "Drop files here or click to upload.",
                          fontWeight: 600,
                          muted: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (controller.files.isNotEmpty) ...[
            MySpacing.height(20),
            GridView.custom(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 155,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 155,
              ),
              childrenDelegate: SliverChildListDelegate(
                controller.files
                    .mapIndexed((index, file) => MyContainer.bordered(
                          borderRadiusAll: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(LucideIcons.file, size: 20),
                              MySpacing.height(8),
                              MyText.bodyMedium(file.name,
                                  maxLines: 1, fontWeight: 600),
                              MySpacing.height(8),
                              MyText.bodySmall(Utils.getStorageStringFromByte(
                                  file.bytes?.length ?? 0)),
                              MySpacing.height(12),
                              MyContainer(
                                onTap: () => controller.removeFile(file),
                                paddingAll: 6,
                                color: contentTheme.danger,
                                child: MyText.bodySmall("Remove File",
                                    fontWeight: 600,
                                    color: contentTheme.onDanger),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}