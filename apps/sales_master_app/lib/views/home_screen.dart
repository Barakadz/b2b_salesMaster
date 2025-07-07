import 'package:flutter/material.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/page_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        children: [
          PageDetail(
            title: "HomeScreen",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          Expanded(child: Container())
        ],
      )),
    );
  }
}
