import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

const int wid=588;

@RoutePage()
class CustMgmtDashBoard extends StatelessWidget {
  const CustMgmtDashBoard({super.key});

  @override
  Widget build(Object context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        direction: Axis.horizontal,
        children: [
          CardMedium(
            height: 290,
            title: 'Available Credit',
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 12.0,
              percent: 0.8,
              center: const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    SelectableText("MYR80,000"),
                    SizedBox(
                      height: 25,
                    ),
                    SelectableText(
                      'Credit Limit',
                    ),
                    SelectableText('MYR100,000'),
                  ],
                ),
              ),
              progressColor: DbColors.primary,
            ),
          ),
          const CardMedium(
              width: 280,
              height: 290,
              title: 'Billing',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText('Outstanding Balance'),
                  SelectableText(
                    'MYR2,650',
                    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                  sbh20,
                  // GestureDetector(
                  //   onTap: (){
                  //     Toast.message("Will load FPX Payment Page");
                  //   },
                  //   child: Container(
                  //    color: Colors.white,
                  //     height: 50,
                  //     child: Image.asset('assets/images/FPX_Logo_FA_Full_FC.png',)

                  //     ),
                  // )
                ],
              )),
          const CardMedium(
              title: 'Card',
              height: 290,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('Active'),
                          SelectableText(
                            '12',
                            //  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ],
                      ),
                      sbw20,
                    ],
                  ),
                  sbh20,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('Pending'),
                          SelectableText(
                            '12',
                            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ],
                      ),
                      sbw20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('Blocked'),
                          SelectableText(
                            '0',
                            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          CardMedium(
            title: 'Fuel Subsidy',
            titleAlign: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SelectableText('Valid 1 Jan 2022 to 31 Dec 2022'),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: 230,
                  animation: true,
                  lineHeight: 15.0,
                  animationDuration: 1500,
                  percent: 0.8,

                  //barRadius: const Radius.circular(20),
                  progressColor: DbColors.warning,
                ),
                sbh20,
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: 0.8,
                  center: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SelectableText("Monthly Utilised"),
                        SelectableText(
                          'MYR3680',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SelectableText('Quota Limit'),
                        SelectableText('MYR5,000'),
                      ],
                    ),
                  ),
                  progressColor: DbColors.primary,
                ),
              ],
            ),
          ),
          CardMedium(
            title: 'Control Limits',
            width: 700,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: 0.2,
                  center: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SelectableText("Per Txn Limit"),
                        SelectableText('MYR200'),
                      ],
                    ),
                  ),
                  progressColor: DbColors.danger,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: 0.8,
                  center: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SelectableText("Daily Usage"),
                        SelectableText("MYR150"),
                        SizedBox(
                          height: 25,
                        ),
                        SelectableText(
                          'Daily Limit',
                        ),
                        SelectableText('MYR500'),
                      ],
                    ),
                  ),
                  progressColor: DbColors.primary,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: 0.8,
                  center: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SelectableText("Monthly Usage"),
                        SelectableText('MYR1600'),
                        SizedBox(
                          height: 25,
                        ),
                        SelectableText(
                          'Daily Limit',
                        ),
                        SelectableText('MYR2000'),
                      ],
                    ),
                  ),
                  progressColor: DbColors.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardMedium extends StatelessWidget {
  const CardMedium({
    super.key,
    required this.child,
    this.title,
    this.titleAlign = Alignment.topLeft,
    this.height = 350,
    this.width = 300,
  });

  final Widget child;
  final String? title;
  final Alignment titleAlign;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SizedBox(
        // decosration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)), border: Border.all(color: Colors.blue)),
        height: height,
        width: width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                title == null
                    ? Container()
                    : Align(
                        alignment: titleAlign,
                        child: SelectableText(
                          title.toString(),
                          //      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                sbh20,
                child,
              ],
            ),
          ),
        ));
  }
}
