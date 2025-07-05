import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/todolist_status_style.dart';
import 'package:sales_master_app/controllers/todolist_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/todolist_card.dart';

class TodolistArchiveScreen extends StatelessWidget {
  const TodolistArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodolistController todolistController = Get.find();
    todolistController.loadFakeArchiveTodolist();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: paddingS,
          ),
          PageDetail(
            title: "To do list",
          ),
          SizedBox(height: paddingXs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My To do list ",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Spacer(),
                MyChip(
                  text: "Done",
                  bgColor: todolistStatusStyle["Done"]!.backgroundColor,
                  textColor: todolistStatusStyle["Done"]!.textColor,
                  prefixWidget: SvgPicture.asset(
                    "assets/dotted_circle.svg",
                    color: todolistStatusStyle["Done"]!.textColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: paddingS,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              hintText: 'Search by task name',
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              filled: true,
              login: false,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingM),
            child: Obx(() {
              return ListView.builder(
                  itemCount: todolistController.archiveTodolist.length,
                  itemBuilder: (context, index) {
                    return TodolistCard(
                        onChecked: () {},
                        todolist: todolistController.archiveTodolist[index]);
                  });
            }),
          )),
        ],
      )),
    );
  }
}
