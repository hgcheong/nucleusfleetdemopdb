import 'package:nucleusv2/src/core/core_imports.dart';

Returndata apiTaskCollEventListMock = Returndata.fromJson(
  {
  "data": [
    {
    "CrtionDate": "2023-08-27T00:24:48.54",
   "RsnCdDscp": "Contact Office No Response",
   "Note": "Additional Notes",
    "ReviewDate": "2023-08-27T00:24:48.54",
    "EffvDate": "2023-08-27T00:24:48.54",
    "CrtBy": "user3",
     "EventId": 1,
      "TasId": 1,
      "EttyId": 1,
      "AcctId": 1,
      "StmtId": 1,
    },
  ],
  "output": [
    {
      "parameter": "@ColCnt",
      "value": 7.0
    },
    {
      "parameter": "@MsgId",
      "value": 10001
    },
    {
      "parameter": "@Return_Value",
      "value": 0
    }
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "CrtionDate",
      "data": "CrtionDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "RsnCdDscp",
      "data": "RsnCdDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Note",
      "data": "Note",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "ReviewDate",
      "data": "ReviewDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "EffvDate",
      "data": "EffvDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "CrtBy",
      "data": "CrtBy",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "EventId",
      "data": "EventId",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "TasId",
      "data": "TasId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "EttyId",
      "data": "EttyId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "AcctId",
      "data": "AcctId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "StmtId",
      "data": "StmtId",
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
}
);

Returndata apiTaskCollAcctMock = Returndata.fromJson({
 "data": [
    {
      "CustName": "Tanjong",
      "AcctNo": "78456184794",
      "PrgDscp": "XFleet Postpaid",
      "StmtDate": "2023-08-27T00:24:48.54",
      "CrLimit": 200,
      "OpnBal": 100,
      "OverdueAmt": 100,
      "OpnCr": 16,
      "DelqcySts": 0,
      "Colltor": "Colltor",
      "TaskStsDscp": "TaskStsDscp",
      "TaskSts": "TaskSts",
      "TaskId": 16,
      "AcctId": 16,
      "PrgId": 16,

    },
  ],
  "output": [
    {
      "parameter": "@ColCnt",
      "value": 11.0
    },
    {
      "parameter": "@MsgId",
      "value": 10001
    },
    {
      "parameter": "@Return_Value",
      "value": 0
    }
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "CustName",
      "data": "CustName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "AcctNo",
      "data": "AcctNo",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "PrgDscp",
      "data": "PrgDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "StmtDate",
      "data": "StmtDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "CrLimit",
      "data": "CrLimit",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OpnBal",
      "data": "OpnBal",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OverdueAmt",
      "data": "OverdueAmt",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OpnCr",
      "data": "OpnCr",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "DelqcySts",
      "data": "DelqcySts",
      "dataType": "int",
      "visible": true
    },
    {
      "title": "Colltor",
      "data": "Colltor",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "TaskStsDscp",
      "data": "TaskStsDscp",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "TaskSts",
      "data": "TaskSts",
      "dataType": "varchar",
      "visible": false
    },
    {
      "title": "TaskId",
      "data": "TaskId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "AcctId",
      "data": "AcctId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "PrgId",
      "data": "PrgId",
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
Returndata apiTaskCollSearchMock = Returndata.fromJson({
 "data": [
    {
      "CustName": "Tanjong",
      "AcctNo": "78456184794",
      "PrgDscp": "XFleet Postpaid",
      "StmtDate": "2023-08-27T00:24:48.54",
      "CrLimit": 200,
      "OpnBal": 100,
      "OverdueAmt": 100,
      "OpnCr": 16,
      "DelqcySts": 0,
      "Colltor": "Colltor",
      "TaskStsDscp": "TaskStsDscp",
      "TaskSts": "TaskSts",
      "TaskId": 16,
      "AcctId": 16,
      "PrgId": 16,

    },
  ],
  "output": [
    {
      "parameter": "@ColCnt",
      "value": 11.0
    },
    {
      "parameter": "@MsgId",
      "value": 10001
    },
    {
      "parameter": "@Return_Value",
      "value": 0
    }
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "CustName",
      "data": "CustName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "AcctNo",
      "data": "AcctNo",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "PrgDscp",
      "data": "PrgDscp",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "StmtDate",
      "data": "StmtDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "CrLimit",
      "data": "CrLimit",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OpnBal",
      "data": "OpnBal",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OverdueAmt",
      "data": "OverdueAmt",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "OpnCr",
      "data": "OpnCr",
      "dataType": "money",
      "visible": true
    },
    {
      "title": "DelqcySts",
      "data": "DelqcySts",
      "dataType": "int",
      "visible": true
    },
    {
      "title": "Colltor",
      "data": "Colltor",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "TaskStsDscp",
      "data": "TaskStsDscp",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "TaskSts",
      "data": "TaskSts",
      "dataType": "varchar",
      "visible": false
    },
    {
      "title": "TaskId",
      "data": "TaskId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "AcctId",
      "data": "AcctId",
      "dataType": "bigint",
      "visible": false
    },
    {
      "title": "PrgId",
      "data": "PrgId",
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