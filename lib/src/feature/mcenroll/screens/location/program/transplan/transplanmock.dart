import 'package:nucleusv2/src/core/core_imports.dart';

Returndata mcenrolltransplan = Returndata.fromJson({
  "data": [
    {
      "PoeDscp": "FRONT END PROCESSOR",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-FEP",
      "SrcPrvderDscp": "PURCHASE-FEP",
      "Poe": "FEP",
      "MsgTypeId": 1,
      "MsgTypePlanId": 1,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    },
    {
      "PoeDscp": "WEB",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-WEB",
      "SrcPrvderDscp": "PURCHASE-WEB",
      "Poe": "WEB",
      "MsgTypeId": 2,
      "MsgTypePlanId": 2,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    },
    {
      "PoeDscp": "MOBILE APP",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-WEB",
      "SrcPrvderDscp": "PURCHASE-WEB",
      "Poe": "APP",
      "MsgTypeId": 2,
      "MsgTypePlanId": 5,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    }
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 4.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 3,
  "columnInfo": [
    {
      "title": "PoeDscp",
      "data": "PoeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "PrgDscp",
      "data": "PrgDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "MsgTypeDscp",
      "data": "MsgTypeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "SrcPrvderDscp",
      "data": "SrcPrvderDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {"title": "Poe", "data": "Poe", "dataType": "varchar", "visible": false},
    {
      "title": "MsgTypeId",
      "data": "MsgTypeId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "MsgTypePlanId",
      "data": "MsgTypePlanId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "TxnPlanRefNo",
      "data": "TxnPlanRefNo",
      "dataType": "int",
      "visible": false
    },
    {
      "title": "PrgEttyId",
      "data": "PrgEttyId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Returndata mcenrolltransplanWEB = Returndata.fromJson({
  "data": [
    {
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-WEB",
      "TxnPlanDscp": null,
      "PoeDscp": "WEB",
      "SrcPrvderDscp": "LAZADA",
      "FromDate": null,
      "ToDate": null,
      "MsgTypePlanId": 2,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1,
      "PlanId": null
    }
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 5.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "PrgDscp",
      "data": "PrgDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "MsgTypeDscp",
      "data": "MsgTypeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "TxnPlanDscp",
      "data": "TxnPlanDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "PoeDscp",
      "data": "PoeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "SrcPrvderDscp",
      "data": "SrcPrvderDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "FromDate",
      "data": "FromDate",
      "dataType": "date",
      "visible": false
    },
    {"title": "ToDate", "data": "ToDate", "dataType": "date", "visible": false},
    {
      "title": "MsgTypePlanId",
      "data": "MsgTypePlanId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "TxnPlanRefNo",
      "data": "TxnPlanRefNo",
      "dataType": "int",
      "visible": false
    },
    {
      "title": "PrgEttyId",
      "data": "PrgEttyId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "PlanId",
      "data": "PlanId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Returndata mcenrolltransplanlist = Returndata.fromJson({
  "data": [
    {
      "PoeDscp": "FRONT END PROCESSOR",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-FEP",
      "SrcPrvderDscp": "PURCHASE-FEP",
      "Poe": "FEP",
      "MsgTypeId": 1,
      "MsgTypePlanId": 1,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    },
    {
      "PoeDscp": "WEB",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-WEB",
      "SrcPrvderDscp": "PURCHASE-WEB",
      "Poe": "WEB",
      "MsgTypeId": 2,
      "MsgTypePlanId": 2,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    },
    {
      "PoeDscp": "MOBILE APP",
      "PrgDscp": "X-Fleet Program (Government Postpaid Kad Inden)",
      "MsgTypeDscp": "PURCHASE-WEB",
      "SrcPrvderDscp": "PURCHASE-WEB",
      "Poe": "APP",
      "MsgTypeId": 2,
      "MsgTypePlanId": 5,
      "TxnPlanRefNo": 3,
      "PrgEttyId": 1
    }
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 4.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 3,
  "columnInfo": [
    {
      "title": "PoeDscp",
      "data": "PoeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "PrgDscp",
      "data": "PrgDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "MsgTypeDscp",
      "data": "MsgTypeDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "SrcPrvderDscp",
      "data": "SrcPrvderDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {"title": "Poe", "data": "Poe", "dataType": "varchar", "visible": false},
    {
      "title": "MsgTypeId",
      "data": "MsgTypeId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "MsgTypePlanId",
      "data": "MsgTypePlanId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "TxnPlanRefNo",
      "data": "TxnPlanRefNo",
      "dataType": "int",
      "visible": false
    },
    {
      "title": "PrgEttyId",
      "data": "PrgEttyId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});
