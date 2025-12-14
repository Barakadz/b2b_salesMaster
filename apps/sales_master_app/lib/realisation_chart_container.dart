import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/realisations_controller.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/widgets/radial_chart.dart';
import 'package:sales_master_app/widgets/salary_note.dart';

class RealisationChartContainer extends StatelessWidget {
  final String date;
  final bool gloabl;
  final double increase;
  final TotalRealisation totalRealisations;
  final double totalrealised;
  final double totalTarget;
  final bool disabled;
 final String? pageTitle;
  const RealisationChartContainer(
      {super.key,
      required this.date,
      required this.gloabl,
      required this.totalrealised,
      required this.totalTarget,
      this.increase = 0,
      this.disabled = false,
      this.pageTitle,
      required this.totalRealisations});

  @override
  Widget build(BuildContext context) {
    final RealisationsController controller =
        Get.find<RealisationsController>();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
      child: Padding(
        padding: const EdgeInsets.all(paddingXs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    final currentIndex = controller.filter
                        .indexOf(controller.selectedQuarter.value);
                    if (currentIndex > 0) {
                      controller.selectedQuarter.value =
                          controller.filter[currentIndex - 1];
                      controller.loadRealisation();
                    }
                  },
                  child: Icon(Icons.chevron_left,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.5)),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                GestureDetector(
                  onTap: () {
                    final currentIndex = controller.filter
                        .indexOf(controller.selectedQuarter.value);
                    if (currentIndex < controller.filter.length - 1) {
                      controller.selectedQuarter.value =
                          controller.filter[currentIndex + 1];
                      controller.loadRealisation();
                    }
                  },
                  child: Icon(Icons.chevron_right,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.5)),
                )
              ],
            ),
             SizedBox(
              height: paddingXs,
            ),
            controller.loadingRealisations.value ==true ? CircularProgressIndicator() :
         totalrealised ==0.0   ?  InkWell(
  onTap: () {
    // Go to another page with GoRouter
                  context.push(AppRoutes.dashboardRealisations.path);
  },
 
           child: Column(
                    children: [
                        SvgPicture.asset(
                //notificationAssets[notification.type],
                'assets/nodata.svg',
                height: 240,
                width: 240,
              ),
                      Text("Aucune réalisation n’a été trouvée pour ce trimestre.",textAlign: TextAlign.center,),
                    ],
                  ),
         ) :  InkWell(
  onTap: () {
    // Go to another page with GoRouter
                  context.push(AppRoutes.dashboardRealisations.path);
  },
           child: Container(
                  height: 200,
                  child: RadialChart(
                    gloabl: gloabl,
                    textColor: disabled == true
                        ? Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.25)
                        : null,
                    realisations: totalRealisations.realisations,
                    totalTarget: totalTarget,
                    totalrealised: totalrealised,//hadda1
                  )),
         ) ,
            SizedBox(
              height: paddingXs,
            ),
            disabled == true
                ? pageTitle=='HomePage'  ?  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "${totalRealisations.increaseResult}%",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    const SizedBox(width: 16),
   Flexible(
  child: Text(
    "Bravo ! Vous avez atteint ${totalRealisations.increaseResult}% de votre objectif total",
    style: TextStyle(
      fontSize: 14,
      color: Colors.blueGrey.shade300,
    ),
    softWrap: true,  
    overflow: TextOverflow.visible,
  ),
),

  ],
)
: InkWell(
  onTap: () {
    context.push(AppRoutes.dashboardRealisations.path);
  },
  child:
  (totalRealisations.increaseResult ?? 0.0) > 70.0
    ? 
   SalaryNote(
                      raise: totalRealisations.increase,
                      borderColor:
                          Theme.of(context).dividerColor.withValues(alpha: 0.5),
                      bgColor:
                          Theme.of(context).dividerColor.withValues(alpha: 0.07),
                      textColor: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.25),
                      prefixSvgPath: "assets/congrat_left.svg",
                      suffixSvgPath: "assets/congrat_right.svg",
                    ) : SizedBox()
)
                : totalRealisations.increase > 0
                    ?pageTitle=='HomePage'  ?  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "${totalRealisations.increaseResult}%",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    const SizedBox(width: 16),
   Flexible(
  child: Text(
    "Bravo ! Vous avez atteint ${totalRealisations.increaseResult}% de votre objectif total",
    style: TextStyle(
      fontSize: 14,
      color: Colors.blueGrey.shade300,
    ),
    softWrap: true,  
    overflow: TextOverflow.visible,
  ),
),

  ],
)
:  (totalRealisations.increaseResult ?? 0.0) > 70.0
    ? SalaryNote(
                        raise: totalRealisations.increase,
                        borderColor: disabled == true
                            ? Theme.of(context)
                                .dividerColor
                                .withValues(alpha: 0.5)
                            : null,
                        bgColor: disabled == true
                            ? Theme.of(context)
                                .dividerColor
                                .withValues(alpha: 0.07)
                            : null,
                        textColor: disabled == true
                            ? Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.25)
                            : null,
                        prefixSvgPath: "assets/congrat_left.svg",
                        suffixSvgPath: "assets/congrat_right.svg",
                      )
                    : SizedBox() :SizedBox()
          ],
        ),
      ),
    );
  }
}
