import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/shared/acx_status_dialog.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/mediainfo/cust_mgmt_media_block_dialog.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/mediainfo/cust_mgmt_media_early_terminate.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/mediainfo/cust_mgmt_media_re_issue.dart';
import 'package:nucleusv2/src/resources/app_colors.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=613;

@RoutePage()
class CustMgmtMediaInfo extends ConsumerWidget {
  const CustMgmtMediaInfo({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mediaEttyId') this.mediaEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
    @PathParam.inherit('issId') this.issId,
  });
//:mediaEttyId/:issId
  final String? custEttyId;
  final String? mediaEttyId;
  final String? issId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // bool isCvvFocused = false;
    // bool useGlassMorphism = false;
    // bool useBackgroundImage = false;
    // String expiryDate = '';
    String cvvCode = '';
    // final formKeyCustMgmtlMediaProp = GlobalKey<FormBuilderState>();

    final qoFormData = QueryObject(
        querysql: '/sp/ApiMgmtMedia/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "IssId": issId,
          "MediaEttyId": convStrNewOrNullToNull(mediaEttyId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "MediaNo": "",
      "PrgDscp": null,
      "BillingEttyTypeDscp": null,
      "MediaCtgryDscp": null,
      "MediaTypeDscp": null,
      "TmntionDate": null,
      "CrtionDate": null,
      "CrtBy": null,
      "MediaStsDscp": null,
      "FirstTxnDate": null,
      "OldMediaNo": null,
      "NewMediaNo": null,
      "HolderName": null,
      "VhcRgsNo": null,
      "VhcTypeDscp": null,
      "AttachTo": null,
      "EmbossLine1": null,
      "EmbossLine2": null,
      "MediaCtgry": null,
      "MediaType": null,
      "BillingEttyType": null,
      "MediaSts": null,
      "PrgType": null,
      "PrgEttyId": null,
      "CustEttyId": custEttyId,
      "MbrEttyId": null,
      "MediaEttyId": mediaEttyId,
      "MediaId": null,
      "BlockFlag":"N",
      "IssId": issId
    };

    // return AsyncValueWidget<Returndata>(value: theData, data: (theResul) {});
    final formData = ref.watch(ReturndatafreezedProvider(qoFormData));
       return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }

          var imgName = 'assets/images/card_bg.png';
          var backImgName = 'assets/images/fleet_card_back.png';
          var driverName = '';
          var vehicleNumber = '';
switch ('${formNewValue["PrgDscp"]}|${formNewValue["MediaCtgry"]}') {
  case 'X-Fleet Kad Inden|STANDALONE':
    imgName = 'assets/images/pdb_kenderaan.png';
    backImgName = 'assets/images/fleet_card_back.png';
    driverName = formNewValue['EmbossLine2'] ?? "";
    vehicleNumber = formNewValue['VhcRgsNo'] ?? "";
      case 'X-Fleet Kad Inden|MASTER':
    imgName = 'assets/images/pdb_kenderaan.png';
    backImgName = 'assets/images/fleet_card_back.png';
    driverName = formNewValue['EmbossLine2'] ?? "";
    vehicleNumber = formNewValue['VhcRgsNo'] ?? "";
  case 'X-Fleet Kad Inden|VEHICLE':
        imgName = 'assets/images/pdb_kenderaan.png';
        backImgName = 'assets/images/fleet_card_back.png';
        driverName = '';
        vehicleNumber = formNewValue['VhcRgsNo'] ?? "";
  case 'X-Fleet Kad Inden|DRIVER':
       imgName = 'assets/images/pdb_kenderaan.png';
       backImgName = 'assets/images/fleet_card_back.png';
      driverName = formNewValue['EmbossLine2'] ?? "";
      vehicleNumber = '';
  default:
      imgName = 'assets/images/pdb_kenderaan.png';
}
          
          return Row(crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Card(
                        child: ListView(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SelectableText(
                                'Media Info',
                                //       style: hdrStyle,
                              ),
                            ),
                            ListTile(
                              leading: const SelectableText("Media Number"),
                              title: SelectableText(
                                formNewValue['MediaNo'] ?? "",
                                textAlign: TextAlign.right,
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
//CustMgmtMediaReissueDialog
                                    // final String? custEttyId;
                                    // final String? issId;
                                    // final String? mbrEttyId;
                                    // final String? mediaEttyId;
                                    // final String? mediaId;
                                    await showAcxDialog(
                                        context,
                                        CustMgmtMediaReissueDialog(
                                          custEttyId: custEttyId,
                                          issId: issId,
                                          mbrEttyId: mbrEttyId,
                                          mediaEttyId: mediaEttyId,
                                          mediaId: formNewValue["MediaId"]
                                              .toString(),
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(qoFormData));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            ListTile(
                              leading: const SelectableText("Current Status"),
                              title: SelectableText(
                                formNewValue["MediaStsDscp"] ?? "",
                                textAlign: TextAlign.right,
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        AcxStatusDialog(
                                          stsType: StatusType.mediaSts,
                                          ettyId: mediaEttyId,
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(qoFormData));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            //               ListTile(
                            //   leading: const SelectableText("Block/Unblock Card"),
                            //   title: SelectableText(
                            //     formNewValue["BlockDate"] == null
                            //         ? ""
                            //         : DateFormat.yMMMEd()
                            //             .format(DateTime.parse(blocsts.data![0]["FromDate"])),
                            //     textAlign: TextAlign.right,
                            //   ),
                            //   trailing: IconButton(
                            //       onPressed: () async {
                            //         await showAcxDialog(
                            //             context,
                            //             CustMgmtMediaBlockDialog(
                            //               custEttyId: custEttyId,
                            //               mediaEttyId: mediaEttyId,
                            //             ));

                            //         ref.invalidate(
                            //             ReturndatafreezedProvider(qoFormData));
                            //       },
                            //       icon: const Icon(Icons.arrow_right)),
                            // ),
                            ListTile(
                              leading: SelectableText( formNewValue["BlockFlag"] == "N" ? "Block Card":"UnBlock Card"),
                              title: SelectableText(formNewValue["BlockDscp"] ?? ""
                              , textAlign: TextAlign.right,),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        CustMgmtMediaBlockDialog(
                                          custEttyId: custEttyId,
                                          mediaEttyId: mediaEttyId,
                                          blockFlag:  formNewValue["BlockFlag"]

                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(qoFormData));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            ListTile(
                              leading: const SelectableText(
                                  "Early Termination Date"),
                              title: SelectableText(
                                formNewValue["TmntionDate"] == null
                                    ? ""
                                    : DateFormat.yMMMEd()
                                        .format(formNewValue["TmntionDate"]),
                                textAlign: TextAlign.right,
                              ),
                              //                         "CustEttyId": "528",
                              // "MbrEttyId": "534",
                              // "MediaEttyId": "535",
                              // "MediaId":14,
                              // "IssId":13
                              trailing: IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        CustMgmtEarlyTerminateDialog(
                                          custEttyId: custEttyId,
                                          mbrEttyId: mbrEttyId,
                                          mediaEttyId: mediaEttyId,
                                          issId: issId,
                                          mediaId: formNewValue["MediaId"]
                                              .toString(),
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(qoFormData));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            ListTile(
                              leading: const SelectableText("Program"),
                              title: SelectableText(
                                formNewValue["PrgDscp"] ?? "",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            ListTile(
                              leading: const SelectableText("Media Category"),
                              title: SelectableText(
                                formNewValue["MediaCtgryDscp"] ?? "",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            //"SKDS": null
                            ListTile(
                              leading: const SelectableText("SKDS No."),
                              title: SelectableText(
                                formNewValue["SKDS"] ?? "",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            ListTile(
                              leading: const SelectableText("Expiry Date"),
                              title: SelectableText(
                                formNewValue["ExpDate"] == null
                                    ? ""
                                    : DateFormat.yMMMEd()
                                        .format(formNewValue["ExpDate"]),
                                textAlign: TextAlign.right,
                              ),
                            ),

                            ListTile(
                              leading: const SelectableText("Creation Date"),
                              title: SelectableText(
                                formNewValue["CrtionDate"] == null
                                    ? ""
                                    : DateFormat.yMMMEd()
                                        .format(formNewValue["CrtionDate"]),
                                textAlign: TextAlign.right,
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SelectableText(
                                'Additional Info',
                                //     style: hdrStyle,
                              ),
                            ),
                            ListTile(
                              leading: const SelectableText("Activation Date"),
                              title: SelectableText(
                                formNewValue["AtvtionDate"] == null
                                    ? ""
                                    : DateFormat.yMMMEd()
                                        .format(formNewValue["AtvtionDate"]),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            ListTile(
                              leading: const SelectableText(
                                  "First Transaction Date"),
                              title: SelectableText(
                                formNewValue["FirstTxnDate"] == null
                                    ? ""
                                    : DateFormat.yMMMEd()
                                        .format(formNewValue["FirstTxnDate"]),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Card(
                  child: ListView(
                    children: [
                      Center(
                        child: CreditCardWidget(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'halter',
                            fontSize: 16,
                            package: 'flutter_credit_card',
                          ),
                          width: 400,
                          height: 250,

                         // cardType: CardType.mastercard,
                      //    glassmorphismConfig: Glassmorphism.defaultConfig(),
                          cardNumber: formNewValue['MediaNo'].toString(),
                          expiryDate: formNewValue['ExpDate'] == null
                              ? ""
                              : DateFormat('MM/yy')
                                  .format(formNewValue['ExpDate']),
                          cardHolderName:  driverName,
                          cvvCode: cvvCode,
                          bankName: vehicleNumber,
                          cmpyName: formNewValue['EmbossLine1'] ?? "",

                          // frontCardBorder: !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                          // backCardBorder: !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                          frontCardBorder: Border.all(color: Colors.grey),
                          backCardBorder: Border.all(color: Colors.grey),
                          showBackView: false,
                          obscureCardNumber: false,
                          obscureCardCvv: false,
                        
                          isHolderNameVisible: true,
                          cardBgColor: AppColors.cardBgColor,
                          
                          backgroundImage: imgName,
                          backgroundImageBack : backImgName,
                          isChipVisible: false,
                          isSwipeGestureEnabled: true,
                        
                          onCreditCardWidgetChange:
                              (CreditCardBrand creditCardBrand) {},
                        //  customCardTypeIcons: <CustomCardTypeIcon>[
                          //   CustomCardTypeIcon(
                          //     cardType: CardType.mastercard,
                          //     cardImage: Image.asset(
                          //       'assets/images/bhplogo.png',
                          //       height: 48,
                          //       width: 48,
                          //     ),
                          //   ),
                          // ],
                        ),
                      ),
                      //     CreditCardWidget(
                      //                      width: 400,
                      //    height: 250,

                      //   cardType: CardType.mastercard,
                      //   glassmorphismConfig: Glassmorphism.defaultConfig(),
                      //   cardNumber: '6394910211388930',
                      //   expiryDate: expiryDate,
                      //   cardHolderName: 'Sam Chong',
                      //   cvvCode: cvvCode,
                      //   bankName: 'BHP XFLEET MANAGER',
                      //   cmpyName: 'TUDM',

                      //   frontCardBorder: !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                      //   backCardBorder: !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                      //   showBackView: isCvvFocused,
                      //   obscureCardNumber: false,
                      //   obscureCardCvv: true,
                      //   isHolderNameVisible: true,
                      //   cardBgColor: AppColors.cardBgOrgColor,
                      //   backgroundImage: 'assets/images/bgOrg.png',
                      //   isSwipeGestureEnabled: true,
                      //   onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                      //   customCardTypeIcons: <CustomCardTypeIcon>[
                      //     CustomCardTypeIcon(
                      //       cardType: CardType.mastercard,
                      //       cardImage: Image.asset(
                      //         'assets/images/bhplogo.png',
                      //         height: 48,
                      //         width: 48,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SelectableText(
                          'Media Holder Info',
                          //  style: hdrStyle,
                        ),
                      ),
  ListTile(
                        leading: const SelectableText("Emboss Line 1"),
                        title: SelectableText(
                          formNewValue['EmbossLine1'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const SelectableText("Emboss Line 2"),
                        title: SelectableText(
                          formNewValue['EmbossLine2'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const SelectableText("Name"),
                        title: SelectableText(
                          formNewValue['HolderName'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const SelectableText("Vehicle Reg.Number"),
                        title: SelectableText(
                          formNewValue['VhcRgsNo'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const SelectableText("Attached to"),
                        title: SelectableText(
                          formNewValue['AttachTo'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                       ListTile(
                        leading: SelectableText("Old Media Number"),
                        title: SelectableText(
                           formNewValue['OldMediaNo'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                       ListTile(
                        leading: SelectableText("New Media Number"),
                        title: SelectableText(
                           formNewValue['NewMediaNo'] ?? "",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [  
                    AcxBackToList(
                      listUrl: '/custmgmt/media/$custEttyId/list',
                    )
                  ],
                ),
              )
            ],
          );

        
    });
   
  }
}

class MediaPropertiesHdr extends StatelessWidget {
  const MediaPropertiesHdr({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const Row(
        children: [
          Flexible(
              child: Column(
            children: [
              SelectableText('Media Holder'),
              SelectableText('Program'),
              SelectableText('PostPaid')
            ],
          )),
          Flexible(
              child: Column(
            children: [
              SelectableText(''),
              SelectableText('Media Category'),
              SelectableText('Vehicle Card')
            ],
          )),
          Flexible(
              child: Column(
            children: [SelectableText(''), SelectableText('1a')],
          )),
        ],
      ),
    );
  }
}

class MediaPropertiesHdr2 extends ConsumerWidget {
  const MediaPropertiesHdr2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaCustMgmtMediaHolderNameProvider);
    final mediaMediaPrgSelect = ref.watch(mediaCustMgmtMediaPrgSelectProvider);
    final mediaMediaCategorySelect =
        ref.watch(mediaCustMgmtMediaCategorySelectProvider);
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText('Media Holder'),
              SelectableText(mediaHolderName),
            ],
          ),
          const Row(
            children: [
              SelectableText('Program'),
              sbw10,
              SelectableText('Media Category'),
            ],
          ),
          Row(
            children: [
              SelectableText(mediaMediaPrgSelect['PrgDscp'] ?? ''),
              sbw10,
              SelectableText(mediaMediaCategorySelect['Dscp'] ?? '')
            ],
          ),
        ],
      ),
    );
  }
}

// Widget returnCardType(String mediaCtry){
//   switch (expression) {
//     case value:

//       break;
//     default:
//   }
// }
