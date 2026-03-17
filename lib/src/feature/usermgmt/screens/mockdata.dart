import 'package:flutter_tree/flutter_tree.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

Returndata toUse = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Kelly@gmail.com",
      "RgstionNo": "Keylly@gmail.com",
      "CustName": "Keylly Smith",
      "ApplRef": "Merchant - Allan D.I.Y",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 16
    },
    {
      "CmpyName": "1234567890",
      "RgstionNo": "Ben@yahoo.com",
      "CustName": "Ben Johnson",
      "ApplRef": "Program - Super",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
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
      "title": "User Id",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Email",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Name",
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
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
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

Returndata accessRightsNucleus = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "System Administrator",
      "RgstionNo": "2",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 16
    },
    {
      "CmpyName": "Card Operation",
      "RgstionNo": "4",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
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
      "title": "Access Rights Group",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "No of User",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
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

Returndata accessRights = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Fleet Manager",
      "RgstionNo": "2",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 16
    },
    {
      "CmpyName": "Fleet user",
      "RgstionNo": "4",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
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
      "title": "Access Rights Group",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "No of User",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
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

Returndata passwordOption = Returndata.fromJson({
  "data": [
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "ADVERTISE",
      "Dscp": "Strong Password",
      "BitInd": 0,
      "Sts": "A"
    },
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "AGRI",
      "Dscp": "Password Never Expired",
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

Returndata dropDownValue = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Administrator",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 16
    },
    {
      "CmpyName": "1234567890",
      "RgstionNo": "Ben@yahoo.com",
      "CustName": "System User",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
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
      "title": "User Id",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Email",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Role",
      "data": "CustName",
      "dataType": "nvarchar",
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
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
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

Returndata dropDownAccessRightsGroup = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Administrator",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 16
    },
    {
      "CmpyName": "1234567890",
      "RgstionNo": "Ben@yahoo.com",
      "CustName": "System User",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
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
      "title": "User Id",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Email",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Role",
      "data": "CustName",
      "dataType": "nvarchar",
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
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
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

Returndata stsChangeHist = Returndata.fromJson({
  "data": [
    {
      "1": "31 Oct 2017 13:13:13",
      "2": "Suspend",
      "3": "Active",
      "4": "ToActive",
      "5": "admin",
      "UserId": 16
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 5.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "Date of Change",
      "data": "1",
      "dataType": "nvarchar",
      "visible": true
    },
    {"title": "From", "data": "2", "dataType": "varchar", "visible": true},
    {"title": "To", "data": "3", "dataType": "nvarchar", "visible": true},
    {"title": "Reason", "data": "4", "dataType": "nvarchar", "visible": true},
    {"title": "User", "data": "5", "dataType": "nvarchar", "visible": true},
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

/// Your server data
final serverData = [
  {
    "checked": true,
    "id": 1,
    "pid": 0,
    "show": false,
    "text": "User Enrolment",
    "children": [
      {
        "checked": true,
        "show": false,
        "children": [],
        "id": 12,
        "pid": 1,
        "text": "Nucleus Users",
      },
      {
        "checked": true,
        "show": false,
        "children": [],
        "id": 13,
        "pid": 1,
        "text": "Web Protal Users",
      },
      {
        "checked": true,
        "show": false,
        "children": [],
        "id": 14,
        "pid": 1,
        "text": "Nuclues Access Rights",
      },
      {
        "checked": false,
        "show": false,
        "children": [],
        "id": 11,
        "pid": 1,
        "text": "Web Access Rights",
      },
    ],
  },
  {
    "checked": true,
    "show": false,
    "children": [],
    "id": 2,
    "pid": 0,
    "text": "Merchant Enrolment",
  },
  {
    "checked": true,
    "children": [],
    "id": 3,
    "pid": 0,
    "show": false,
    "text": "Customer Enrolment",
  },
];

//First thing is to get it in flat list and start at level 0.

/// Map server data to tree node data
TreeNodeData mapServerDataToTreeData(Map data) {
  return TreeNodeData(
    extra: data,
    title: data['text'],
    expaned: data['show'],
    checked: data['checked'],
    children:
        List.from(data['children'].map((x) => mapServerDataToTreeData(x))),
  );
}

/// Generate tree data
List<TreeNodeData> treeData = List.generate(
  serverData.length,
  (index) => mapServerDataToTreeData(serverData[index]),
);
