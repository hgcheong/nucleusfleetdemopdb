import 'package:nucleusv2/src/core/core_imports.dart';

Returndata dropDownViewStatement = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Current",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 16
    },
    {
      "CmpyName": "Purchase",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 17
    },
    {
      "CmpyName": "Sylvia Park",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 18
    }
  ]
});

Returndata toUseLast3MonthBank = Returndata.fromJson({
 "data": [
   {
    "FinYear": 2025,
    "FinMonth": "Mar",
    "FlowYear":2025,
    "FlowMonth":"Mar",
    "OpnBal":10000,
    "InFlow":5000,
    "OutFlow":2000,
    "CustEttyId": 528,
    "CmpyEttyId": 529,
    "PrgEttyId": 4,
},
   {
    "FinYear": 2025,
    "FinMonth": "Feb",
    "FlowYear":2025,
    "FlowMonth":"Feb",
    "OpnBal":150000,
    "InFlow":5000,
    "OutFlow":2000,
    "CustEttyId": 528,
    "CmpyEttyId": 529,
    "PrgEttyId": 4,
},
{
    "FinYear": 2025,
    "FinMonth": "Jan",
    "FlowYear":2025,
    "FlowMonth":"Jan",
    "OpnBal":10000,
    "InFlow":5000,
    "OutFlow":2000,
    "CustEttyId": 528,
    "CmpyEttyId": 529,
    "PrgEttyId": 4,
}
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 7.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 3,
  "columnInfo": [
    {
      "title": "FinYear",
      "data": "FinYear",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "FinMonth",
      "data": "FinMonth",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "FlowYear",
      "data": "FlowYear",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "FlowMonth",
      "data": "FlowMonth",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "OpenBal",
      "data": "OpenBal",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "InFlow",
      "data": "InFlow",
      "dataType": "nvarchar",
      "visible": true
    },
   {
      "title": "OutFlow",
      "data": "OutFlow",
      "dataType": "nvarchar",
      "visible": true
    },
       {
      "title": "CustEttyId",
      "data": "CustEttyId",
      "dataType": "bigint",
      "visible": true
    },
       {
      "title": "CmpyEttyId",
      "data": "CmpyEttyId",
      "dataType": "bigint",
      "visible": true
    },
     {
      "title": "PrgEttyId",
      "data": "PrgEttyId",
      "dataType": "bigint",
      "visible": true
    },
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Returndata toUseTxnList = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "7200 0010 5900 0001",
      "RgstionNo": "Midway Kenny Hill",
      "CustName": "68.87",
      "ApplRef": "Merchant - Allan D.I.Y",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "abc": "abc",
      "UserId": 16,
      "TxnId": 112233,
      "TxnDate": "01 Aug 2020",
      "PostDate": "01 Aug 2020",
      "MediaNumber": "7200 0010 5900 0001",
      "AuthCard": "7200 0010 5910 1234",
      "TypeOfTran": "Purchase",
      "Description": "Midway Kenny Hill",
      "TxnAmount": "68.87",
      "MerchantID": "123456789012345",
      "TID": "12345678",
      "STAN": "012345",
      "RRN": "112233445566",
      "Odometer": "12735"
    },
    {
      "CmpyName": "7200 0010 8703 0002",
      "RgstionNo": "Driveway Beach Road",
      "CustName": "128.88",
      "ApplRef": "Program - Super",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 4.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "Date",
      "data": "CrtionDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "Card Number",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Description",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Amount",
      "data": "CustName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Currently attach to",
      "data": "ApplRef",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Sign-In Failed",
      "data": "SubmtDate",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "Status",
      "data": "AppvDate",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "UserId",
      "data": "UserId",
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

Returndata toUsePrdList = Returndata.fromJson({
  "data": [
    {
      "UserId": 1,
      "Product": "Fuel 97",
      "UnitPrice": "3.233",
      "Quantity": "21.302",
      "TotalAmount": "68.87"
    },
    {
      "UserId": 2,
      "Product": "Fuel 97",
      "UnitPrice": "3.233",
      "Quantity": "21.302",
      "TotalAmount": "68.87"
    }
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 4.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "Product",
      "data": "Product",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "UnitPrice",
      "data": "UnitPrice",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Quantity",
      "data": "Quantity",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "TotalAmount",
      "data": "TotalAmount",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "UserId",
      "data": "UserId",
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

Returndata toUseMediaList = Returndata.fromJson({
  "data": [
    {
      "MediaNumber": "7200 0010 5900 0001",
      "Member": "Gordon",
      "Program": "Fleet Postpaid",
      "MediaCat": "Vehicle Card",
      "Vchnumber": "ABC1234D",
      "Status": "Active",
      "LastTxnDate": "2023-08-27T00:24:48.54",
      "abc": "abc",
      "MediaId": 16,
    },
    {
      "MediaNumber": "7200 0010 5900 0002",
      "Member": "Gordon",
      "Program": "Fleet Postpaid",
      "MediaCat": "Personal Card",
      "Vchnumber": "",
      "Status": "Active",
      "LastTxnDate": "2023-08-27T00:24:48.54",
      "abc": "abc",
      "MediaId": 15,
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 7.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "Media Number",
      "data": "MediaNumber",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Member",
      "data": "Member",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Program",
      "data": "Program",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Media Category",
      "data": "MediaCat",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Vehicle No",
      "data": "Vchnumber",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Last Trn Date",
      "data": "LastTxnDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "Status",
      "data": "Status",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "MediaId",
      "data": "MediaId",
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

Returndata addUserOption = Returndata.fromJson({
  "data": [
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "MGR",
      "Dscp": "Fleet Manager",
      "BitInd": 0,
      "Sts": "A"
    },
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "USER",
      "Dscp": "Fleet User",
      "BitInd": 0,
      "Sts": "A"
    },
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "APP",
      "Dscp": "Mobile App User",
      "BitInd": 0,
      "Sts": "A"
    },
  ],
  "output": [
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "RefType",
      "data": "RefType",
      "dataType": "varchar",
      "visible": true
    },
    {"title": "RefCd", "data": "RefCd", "dataType": "varchar", "visible": true},
    {"title": "Dscp", "data": "Dscp", "dataType": "nvarchar", "visible": true},
    {
      "title": "BitInd",
      "data": "BitInd",
      "dataType": "bigint",
      "visible": true
    },
    {"title": "Sts", "data": "Sts", "dataType": "varchar", "visible": true}
  ],
  "message": null,
  "error": null
});
