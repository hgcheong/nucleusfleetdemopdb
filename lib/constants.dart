import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

// ── DiBold theme colours ─────────────────────────────────────────────────
// Previous values kept in comments for reference / rollback.
const primaryColor = DbColors.primary700; // was Color.fromARGB(255, 70, 74, 83)
const secondaryColor = DbColors.slate600; // was Color(0xFF2A2D3E)
const primarylightColor = DbColors.primary; // was Color.fromARGB(255, 184, 56, 56)
const secondarylightColor = DbColors.primary400; // was Color.fromARGB(255, 67, 89, 212)

const bgColor = DbColors.slate900; // was Color(0xFF212332)

//This one affect the side tab
const colorSelected = DbColors.primary; // was Color.fromARGB(255, 184, 56, 56)
const colorUnSelected = DbColors.slate500; // was Color.fromARGB(255, 67, 89, 212)

// Selected icon in side tab / side drawer
const tabBarColor = DbColors.primary; // was Color.fromARGB(255, 210, 125, 6)

const tabBarLabelStyle = TextStyle(fontWeight: FontWeight.bold);
const tabBarUnselectedStyle = TextStyle();

const defaultPadding = 16.0;
const radiusGrid = 12.0; // DiBold rounded corners
const defaultFontSize = 12.0;
const defaultDropDownSize = 16.0;
const defaultFloatlableSize = 14.0;
// null = inherit the theme font (Nunito Sans, DiBold's typeface).
// Set back to 'Arial' to use the bundled Arial font instead.
const String? defaultFontFamily = null;
const defaultWhite = DbColors.slate500; // was Colors.white54
const defaultTextStyle = TextStyle(
    fontSize: defaultFontSize, fontFamily: defaultFontFamily, color: Colors.white);
const defaultWhiteTextStyle = TextStyle(
    fontSize: defaultFontSize, fontFamily: defaultFontFamily, color: Colors.black);
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
      cellTextStyle: TextStyle(
          fontSize: defaultFontSize,
          fontFamily: defaultFontFamily,
          color: DbColors.slate800),
      columnTextStyle: TextStyle(
          fontSize: defaultFontSize,
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w700,
          color: DbColors.slate600),
      gridBorderRadius: BorderRadius.all(Radius.circular(radiusGrid)),
      gridBackgroundColor: DbColors.white,
      rowColor: DbColors.white,
      borderColor: DbColors.slate200,
      gridBorderColor: DbColors.slate200,
      activatedColor: DbColors.primary50,
      activatedBorderColor: DbColors.primary,
      iconColor: DbColors.slate600,
      menuBackgroundColor: DbColors.white,
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
            color: DbColors.slate100),
        columnTextStyle: TextStyle(
            fontSize: defaultFontSize,
            fontFamily: defaultFontFamily,
            color: DbColors.slate100),
        gridBorderRadius: BorderRadius.all(Radius.circular(radiusGrid)),
        borderColor: DbColors.slate700,
        gridBorderColor: DbColors.slate600,
        rowColor: DbColors.slate800,
        activatedColor: DbColors.primary900,
        activatedBorderColor: DbColors.primary400,
        iconColor: DbColors.slate300,
        menuBackgroundColor: DbColors.slate700,
        gridBackgroundColor: DbColors.slate800,
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
    TextStyle(fontWeight: FontWeight.bold, color: DbColors.primary);

 const regexLatitute = r'^-?([0-8]?[0-9]|90)(\.[0-9]{1,10})?$';


 const regexLongitute = r'^(?:-?1(?:[0-7]?\d(?:\.\d+)?|80(?:\.0+)?)|-?\d{1,2}(?:\.\d+)?)$';


 const logSPUserName = 'hg.cheong';