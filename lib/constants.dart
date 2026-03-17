import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

//const primaryColor = Color(0xFF2697FF);
const primaryColor = Color.fromARGB(255, 70, 74, 83);
const secondaryColor = Color(0xFF2A2D3E);
//const primarylightColor = Color.fromARGB(255, 255, 255, 255);
const primarylightColor = Color.fromARGB(255, 184, 56, 56);
const secondarylightColor = Color.fromARGB(255, 67, 89, 212);

const bgColor = Color(0xFF212332);

//This one affect the side tab
//const colorSelected = Color.fromARGB(255, 221, 219, 219);
//const colorSelected = Color.fromARGB(255, 211, 185, 185);
const colorSelected = Color.fromARGB(255, 184, 56, 56);
//const colorSelected = Color.fromARGB(255, 70, 74, 83);
//const colorUnSelected = Colors.white54;
const colorUnSelected = Color.fromARGB(255, 67, 89, 212);

const tabBarColor = Color.fromARGB(255, 210, 125, 6);
// const tabBarLabelStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
// const tabBarUnselectedStyle = TextStyle(fontSize: 10);

const tabBarLabelStyle = TextStyle(fontWeight: FontWeight.bold);
const tabBarUnselectedStyle = TextStyle();

const defaultPadding = 16.0;
const defaultFontSize = 12.0;
const defaultDropDownSize = 16.0;
const defaultFloatlableSize = 14.0;
const defaultFontFamily = 'Arial';
const defaultWhite = Colors.white54;
const defaultTextStyle = TextStyle(
    fontSize: defaultFontSize, fontFamily: 'Arial', color: Colors.white);
const defaultWhiteTextStyle = TextStyle(
    fontSize: defaultFontSize, fontFamily: 'Arial', color: Colors.black);
const defaultTrans = TransitionsBuilders.fadeIn;
const defaultTransTime = 400;
const svgPath = "assets/icons/";


const defaultWhitePlutoConfig = TrinaGridConfiguration(
    // columnSize: TrinaGridColumnSizeConfig(
    //     autoSizeMode: TrinaAutoSizeMode.none,
    //     resizeMode: TrinaResizeMode.none),
    
    style: TrinaGridStyleConfig(
      columnHeight: 30,
      rowHeight: 25,
         columnFilterHeight: 30,
      enableColumnBorderVertical: false,
      enableCellBorderVertical: false,
      enableCellBorderHorizontal: false,
      cellTextStyle:
          TextStyle(fontSize: defaultFontSize, fontFamily: defaultFontFamily),
      columnTextStyle:
          TextStyle(fontSize: defaultFontSize, fontFamily: defaultFontFamily),
      gridBorderRadius: BorderRadius.all(Radius.circular(10)),
      borderColor: secondaryColor,
      activatedColor: Colors.blue,
    ));

const defaultDarkPlutoConfig = TrinaGridConfiguration.dark(
    
    // columnSize: TrinaGridColumnSizeConfig(
      
    //     autoSizeMode: TrinaAutoSizeMode.none,
    //     resizeMode: TrinaResizeMode.normal),
    style: TrinaGridStyleConfig.dark(
           columnHeight: 30,
      rowHeight: 25,
    columnFilterHeight: 30,
        cellTextStyle: TextStyle(
            fontSize: defaultFontSize,
            fontFamily: defaultFontFamily,
            color: Colors.white),
        columnTextStyle: TextStyle(
            fontSize: defaultFontSize,
            fontFamily: defaultFontFamily,
            color: Colors.white),
        gridBorderRadius: BorderRadius.all(Radius.circular(10)),
        borderColor: secondaryColor,
        rowColor:  Color.fromRGBO(61, 57, 53, 1),
        activatedColor: Colors.blue,
     //   gridBackgroundColor: secondaryColor
     gridBackgroundColor: Color.fromRGBO(61, 57, 53, 1),
        ));

typedef ManyOperation = Function(int firstNo, int secondNo);

//FormBuilder

const librefquerysql = "/sp/GetLibRef/queryasyncnouser";
//UI sizing
const sbw10 = SizedBox(
  width: 10,
);

const sbw20 = SizedBox(
  width: 20,
);

const sbw54 = SizedBox(
  width: 54,
);

const sbh10 = SizedBox(
  height: 10,
);

const sbh20 = SizedBox(
  height: 20,
);

const div = Divider();

//adding(int firstNo, int second) {}

const emptyTab = Tab(
  height: 0,
  iconMargin: EdgeInsets.all(0),
  text: '',
);

// const hdrStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
// const boldStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
// const lblStyle = TextStyle(fontSize: 10);
// const appTextStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.lightBlue);

const hdrStyle = TextStyle(fontWeight: FontWeight.bold);
const boldStyle = TextStyle(fontWeight: FontWeight.bold);
const lblStyle = TextStyle(fontSize: 12);
const appTextStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue);

 const regexLatitute = r'^-?([0-8]?[0-9]|90)(\.[0-9]{1,10})?$';


 const regexLongitute = r'^(?:-?1(?:[0-7]?\d(?:\.\d+)?|80(?:\.0+)?)|-?\d{1,2}(?:\.\d+)?)$';


 const logSPUserName = 'hg.cheong';