// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get homeScreenTitle {
    return Intl.message('Home', name: 'homeScreenTitle', desc: '', args: []);
  }

  /// `Edit`
  String get eDit {
    return Intl.message('Edit', name: 'eDit', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Categories`
  String get categoriesScreenTitle {
    return Intl.message(
      'Categories',
      name: 'categoriesScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get usersScreenTitle {
    return Intl.message('Users', name: 'usersScreenTitle', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `Spanish US`
  String get languageSpanishUS {
    return Intl.message(
      'Spanish US',
      name: 'languageSpanishUS',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get languageJapanese {
    return Intl.message(
      'Japanese',
      name: 'languageJapanese',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get languageChinese {
    return Intl.message('Chinese', name: 'languageChinese', desc: '', args: []);
  }

  /// `BM`
  String get languageMalay {
    return Intl.message('BM', name: 'languageMalay', desc: '', args: []);
  }

  /// `Settings`
  String get settingsScreenTitle {
    return Intl.message(
      'Settings',
      name: 'settingsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Task Queue`
  String get sbTaskQueue {
    return Intl.message('Task Queue', name: 'sbTaskQueue', desc: '', args: []);
  }

  /// `Customer Enrolment`
  String get sbCustomerEnrolment {
    return Intl.message(
      'Customer Enrolment',
      name: 'sbCustomerEnrolment',
      desc: '',
      args: [],
    );
  }

  /// `Customer Management`
  String get sbCustomerMangement {
    return Intl.message(
      'Customer Management',
      name: 'sbCustomerMangement',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Enrolment`
  String get sbMerchantEnrolment {
    return Intl.message(
      'Merchant Enrolment',
      name: 'sbMerchantEnrolment',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Management`
  String get sbMerchantManagement {
    return Intl.message(
      'Merchant Management',
      name: 'sbMerchantManagement',
      desc: '',
      args: [],
    );
  }

  /// `Data Entry`
  String get sbDataEntry {
    return Intl.message('Data Entry', name: 'sbDataEntry', desc: '', args: []);
  }

  /// `Mass Change`
  String get sbMassChange {
    return Intl.message(
      'Mass Change',
      name: 'sbMassChange',
      desc: '',
      args: [],
    );
  }

  /// `Bulk Card Production`
  String get sbBulkMediaProduction {
    return Intl.message(
      'Bulk Card Production',
      name: 'sbBulkMediaProduction',
      desc: '',
      args: [],
    );
  }

  /// `Report Viewer`
  String get sbReportViewer {
    return Intl.message(
      'Report Viewer',
      name: 'sbReportViewer',
      desc: '',
      args: [],
    );
  }

  /// `Online Network Mtr`
  String get sbOnlineNetworkMtr {
    return Intl.message(
      'Online Network Mtr',
      name: 'sbOnlineNetworkMtr',
      desc: '',
      args: [],
    );
  }

  /// `Program Management`
  String get sbProgramManagement {
    return Intl.message(
      'Program Management',
      name: 'sbProgramManagement',
      desc: '',
      args: [],
    );
  }

  /// `Workflow Management`
  String get sbWorkflowManagement {
    return Intl.message(
      'Workflow Management',
      name: 'sbWorkflowManagement',
      desc: '',
      args: [],
    );
  }

  /// `User Management`
  String get sbUserManagement {
    return Intl.message(
      'User Management',
      name: 'sbUserManagement',
      desc: '',
      args: [],
    );
  }

  /// `System Configuration`
  String get sbSystemConfiguration {
    return Intl.message(
      'System Configuration',
      name: 'sbSystemConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Dash Board`
  String get sbDashboard {
    return Intl.message('Dash Board', name: 'sbDashboard', desc: '', args: []);
  }

  /// `Program Setting`
  String get tabProgramSetting {
    return Intl.message(
      'Program Setting',
      name: 'tabProgramSetting',
      desc: '',
      args: [],
    );
  }

  /// `Online Access`
  String get tabOnlineAccess {
    return Intl.message(
      'Online Access',
      name: 'tabOnlineAccess',
      desc: '',
      args: [],
    );
  }

  /// `General Info`
  String get lblGeneralInfo {
    return Intl.message(
      'General Info',
      name: 'lblGeneralInfo',
      desc: '',
      args: [],
    );
  }

  /// `Program Name`
  String get lblProgramName {
    return Intl.message(
      'Program Name',
      name: 'lblProgramName',
      desc: '',
      args: [],
    );
  }

  /// `Program Period`
  String get lblProgramPeriod {
    return Intl.message(
      'Program Period',
      name: 'lblProgramPeriod',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get lblFrom {
    return Intl.message('From', name: 'lblFrom', desc: '', args: []);
  }

  /// `To`
  String get lblTo {
    return Intl.message('To', name: 'lblTo', desc: '', args: []);
  }

  /// `Type of Program`
  String get lblTypeOfProgram {
    return Intl.message(
      'Type of Program',
      name: 'lblTypeOfProgram',
      desc: '',
      args: [],
    );
  }

  /// `Market Segment`
  String get lblMarketSegment {
    return Intl.message(
      'Market Segment',
      name: 'lblMarketSegment',
      desc: '',
      args: [],
    );
  }

  /// `Card Production Interface Format`
  String get lblMediaProdInterfaceFormat {
    return Intl.message(
      'Card Production Interface Format',
      name: 'lblMediaProdInterfaceFormat',
      desc: '',
      args: [],
    );
  }

  /// `Setup Online User access`
  String get lblSetupOnlineUserAccess {
    return Intl.message(
      'Setup Online User access',
      name: 'lblSetupOnlineUserAccess',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get lblEmail {
    return Intl.message('Email', name: 'lblEmail', desc: '', args: []);
  }

  /// `User ID`
  String get lblUserID {
    return Intl.message('User ID', name: 'lblUserID', desc: '', args: []);
  }

  /// `Current Status`
  String get lblCurrentStatus {
    return Intl.message(
      'Current Status',
      name: 'lblCurrentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get lblPassword {
    return Intl.message('Password', name: 'lblPassword', desc: '', args: []);
  }

  /// `User Info`
  String get lblUserInfo {
    return Intl.message('User Info', name: 'lblUserInfo', desc: '', args: []);
  }

  /// `Access Rights`
  String get lblAccessRights {
    return Intl.message(
      'Access Rights',
      name: 'lblAccessRights',
      desc: '',
      args: [],
    );
  }

  /// `Web Portal`
  String get lblWebPortal {
    return Intl.message('Web Portal', name: 'lblWebPortal', desc: '', args: []);
  }

  /// `Mobile Apps`
  String get lblMobileApps {
    return Intl.message(
      'Mobile Apps',
      name: 'lblMobileApps',
      desc: '',
      args: [],
    );
  }

  /// `Password Option`
  String get lblPasswordOption {
    return Intl.message(
      'Password Option',
      name: 'lblPasswordOption',
      desc: '',
      args: [],
    );
  }

  /// `Strong Password`
  String get lblStrongPassword {
    return Intl.message(
      'Strong Password',
      name: 'lblStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Never Expired`
  String get lblPasswordNeverExpired {
    return Intl.message(
      'Password Never Expired',
      name: 'lblPasswordNeverExpired',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get lblAction {
    return Intl.message('Action', name: 'lblAction', desc: '', args: []);
  }

  /// `Un-Block User`
  String get lblUnblockUser {
    return Intl.message(
      'Un-Block User',
      name: 'lblUnblockUser',
      desc: '',
      args: [],
    );
  }

  /// `Program`
  String get lblProgram {
    return Intl.message('Program', name: 'lblProgram', desc: '', args: []);
  }

  /// `TAD`
  String get tabTAD {
    return Intl.message('TAD', name: 'tabTAD', desc: '', args: []);
  }

  /// `Transaction`
  String get tabTransaction {
    return Intl.message(
      'Transaction',
      name: 'tabTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Postpaid BF`
  String get tabPostpaidBF {
    return Intl.message(
      'Postpaid BF',
      name: 'tabPostpaidBF',
      desc: '',
      args: [],
    );
  }

  /// `Postpaid OI`
  String get tabPostpaidOI {
    return Intl.message(
      'Postpaid OI',
      name: 'tabPostpaidOI',
      desc: '',
      args: [],
    );
  }

  /// `Prepaid`
  String get tabPrepaid {
    return Intl.message('Prepaid', name: 'tabPrepaid', desc: '', args: []);
  }

  /// `Prepaid Credit`
  String get tabPrepaidCredit {
    return Intl.message(
      'Prepaid Credit',
      name: 'tabPrepaidCredit',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get tabBankAccount {
    return Intl.message(
      'Bank Account',
      name: 'tabBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Number Range`
  String get tabNumberRange {
    return Intl.message(
      'Number Range',
      name: 'tabNumberRange',
      desc: '',
      args: [],
    );
  }

  /// `Card Type`
  String get tabMediaType {
    return Intl.message('Card Type', name: 'tabMediaType', desc: '', args: []);
  }

  /// `Payments`
  String get tabPayments {
    return Intl.message('Payments', name: 'tabPayments', desc: '', args: []);
  }

  /// `Card`
  String get tabMedia {
    return Intl.message('Card', name: 'tabMedia', desc: '', args: []);
  }

  /// `Fees`
  String get tabFees {
    return Intl.message('Fees', name: 'tabFees', desc: '', args: []);
  }

  /// `Disc  Rebate`
  String get tabDiscRebate {
    return Intl.message(
      'Disc  Rebate',
      name: 'tabDiscRebate',
      desc: '',
      args: [],
    );
  }

  /// `Control`
  String get tabControl {
    return Intl.message('Control', name: 'tabControl', desc: '', args: []);
  }

  /// `Billing`
  String get tabBilling {
    return Intl.message('Billing', name: 'tabBilling', desc: '', args: []);
  }

  /// `Finance  LPC Charge`
  String get tabFinanceLPCCharge {
    return Intl.message(
      'Finance  LPC Charge',
      name: 'tabFinanceLPCCharge',
      desc: '',
      args: [],
    );
  }

  /// `Payment Priority`
  String get tabPaymentPriority {
    return Intl.message(
      'Payment Priority',
      name: 'tabPaymentPriority',
      desc: '',
      args: [],
    );
  }

  /// `Delinquency Status`
  String get tabDelinquencySts {
    return Intl.message(
      'Delinquency Status',
      name: 'tabDelinquencySts',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get tabPlan {
    return Intl.message('Plan', name: 'tabPlan', desc: '', args: []);
  }

  /// `Finance Charge`
  String get lblFinanceCharge {
    return Intl.message(
      'Finance Charge',
      name: 'lblFinanceCharge',
      desc: '',
      args: [],
    );
  }

  /// `Late Payment Charge`
  String get lblLatePaymentCharge {
    return Intl.message(
      'Late Payment Charge',
      name: 'lblLatePaymentCharge',
      desc: '',
      args: [],
    );
  }

  /// `Finance Charge will be impose after the interest free period, calculate based`
  String get lblFinanceChargeDesc {
    return Intl.message(
      'Finance Charge will be impose after the interest free period, calculate based',
      name: 'lblFinanceChargeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Daily balance in arrears`
  String get lblDailyBalInArrears {
    return Intl.message(
      'Daily balance in arrears',
      name: 'lblDailyBalInArrears',
      desc: '',
      args: [],
    );
  }

  /// `Balance in arrears as of the last day of statement`
  String get lblBalInArrLastStmt {
    return Intl.message(
      'Balance in arrears as of the last day of statement',
      name: 'lblBalInArrLastStmt',
      desc: '',
      args: [],
    );
  }

  /// `Finance Charge Plan`
  String get lblFinanceChargePlan {
    return Intl.message(
      'Finance Charge Plan',
      name: 'lblFinanceChargePlan',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Category subjected to Finance Charge`
  String get lblTxnCatDesc {
    return Intl.message(
      'Transaction Category subjected to Finance Charge',
      name: 'lblTxnCatDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings will be appply to all category if no entry in the list`
  String get lblTxnCatSettingDesc {
    return Intl.message(
      'Settings will be appply to all category if no entry in the list',
      name: 'lblTxnCatSettingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Add Entry`
  String get lblAddEntry {
    return Intl.message('Add Entry', name: 'lblAddEntry', desc: '', args: []);
  }

  /// `LPC Plan`
  String get lblLPCPlan {
    return Intl.message('LPC Plan', name: 'lblLPCPlan', desc: '', args: []);
  }

  /// `Statement due days`
  String get lblStatementDueDays {
    return Intl.message(
      'Statement due days',
      name: 'lblStatementDueDays',
      desc: '',
      args: [],
    );
  }

  /// `Overdue Grace Period`
  String get lblOverDueGracePrd {
    return Intl.message(
      'Overdue Grace Period',
      name: 'lblOverDueGracePrd',
      desc: '',
      args: [],
    );
  }

  /// `Min. Repayment`
  String get lblMinRePayment {
    return Intl.message(
      'Min. Repayment',
      name: 'lblMinRePayment',
      desc: '',
      args: [],
    );
  }

  /// `whichever is higher`
  String get lblWhichHigher {
    return Intl.message(
      'whichever is higher',
      name: 'lblWhichHigher',
      desc: '',
      args: [],
    );
  }

  /// `Statement Interest free period`
  String get lblStmtIntFree {
    return Intl.message(
      'Statement Interest free period',
      name: 'lblStmtIntFree',
      desc: '',
      args: [],
    );
  }

  /// `OS Aging Buckets`
  String get lblOSAgingBuc {
    return Intl.message(
      'OS Aging Buckets',
      name: 'lblOSAgingBuc',
      desc: '',
      args: [],
    );
  }

  /// `Customer Setup`
  String get lblCustSetup {
    return Intl.message(
      'Customer Setup',
      name: 'lblCustSetup',
      desc: '',
      args: [],
    );
  }

  /// `Customer and Card Settings`
  String get sbCustMedSettings {
    return Intl.message(
      'Customer and Card Settings',
      name: 'sbCustMedSettings',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get sbMain {
    return Intl.message('Main', name: 'sbMain', desc: '', args: []);
  }

  /// `Transaction`
  String get sbTransaction {
    return Intl.message(
      'Transaction',
      name: 'sbTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Limits`
  String get tabTransactionLimits {
    return Intl.message(
      'Transaction Limits',
      name: 'tabTransactionLimits',
      desc: '',
      args: [],
    );
  }

  /// `Program General Settings`
  String get sbProgramGeneralSettings {
    return Intl.message(
      'Program General Settings',
      name: 'sbProgramGeneralSettings',
      desc: '',
      args: [],
    );
  }

  /// `Merchant and Location Settings`
  String get sbMerchantLocSettings {
    return Intl.message(
      'Merchant and Location Settings',
      name: 'sbMerchantLocSettings',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Setup`
  String get lblMchtSetup {
    return Intl.message(
      'Merchant Setup',
      name: 'lblMchtSetup',
      desc: '',
      args: [],
    );
  }

  /// `Auto Payment`
  String get tabAutoPayment {
    return Intl.message(
      'Auto Payment',
      name: 'tabAutoPayment',
      desc: '',
      args: [],
    );
  }

  /// `Auto Credit`
  String get lblAutoCredit {
    return Intl.message(
      'Auto Credit',
      name: 'lblAutoCredit',
      desc: '',
      args: [],
    );
  }

  /// `Auto Debit`
  String get lblAutoDebit {
    return Intl.message('Auto Debit', name: 'lblAutoDebit', desc: '', args: []);
  }

  /// `To setup auto payment to Merchant at Program level please select your Payment Bank Debit andor Receiving Bank Credit, and enter the Bank Account Number and other details as below`
  String get lblAutoPaymentDesc {
    return Intl.message(
      'To setup auto payment to Merchant at Program level please select your Payment Bank Debit andor Receiving Bank Credit, and enter the Bank Account Number and other details as below',
      name: 'lblAutoPaymentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto Cr Merchant x day after settlement`
  String get lblAutoCrMerctx {
    return Intl.message(
      'Auto Cr Merchant x day after settlement',
      name: 'lblAutoCrMerctx',
      desc: '',
      args: [],
    );
  }

  /// `Auto Db Merchant x day after settlement`
  String get lblAutoDbMerctx {
    return Intl.message(
      'Auto Db Merchant x day after settlement',
      name: 'lblAutoDbMerctx',
      desc: '',
      args: [],
    );
  }

  /// `Bank Details`
  String get lblBankDetails {
    return Intl.message(
      'Bank Details',
      name: 'lblBankDetails',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get lblBank {
    return Intl.message('Bank', name: 'lblBank', desc: '', args: []);
  }

  /// `Bank Account Type`
  String get lblBankAccountType {
    return Intl.message(
      'Bank Account Type',
      name: 'lblBankAccountType',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get lblBankAccountNumber {
    return Intl.message(
      'Bank Account Number',
      name: 'lblBankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Account Holder Name`
  String get lblAccountHolderName {
    return Intl.message(
      'Account Holder Name',
      name: 'lblAccountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Payee Code`
  String get lblPayeeCode {
    return Intl.message('Payee Code', name: 'lblPayeeCode', desc: '', args: []);
  }

  /// `Payee Reference`
  String get lblPayeeReference {
    return Intl.message(
      'Payee Reference',
      name: 'lblPayeeReference',
      desc: '',
      args: [],
    );
  }

  /// `TAD`
  String get lblTAD {
    return Intl.message('TAD', name: 'lblTAD', desc: '', args: []);
  }

  /// `Define the applicable Transacation Acceptance Device Fees at Program Level`
  String get lblTADDesc {
    return Intl.message(
      'Define the applicable Transacation Acceptance Device Fees at Program Level',
      name: 'lblTADDesc',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Plan`
  String get lblTransactionPlan {
    return Intl.message(
      'Transaction Plan',
      name: 'lblTransactionPlan',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Plan`
  String get tabTransactionPlan {
    return Intl.message(
      'Transaction Plan',
      name: 'tabTransactionPlan',
      desc: '',
      args: [],
    );
  }

  /// `TAD fee at Program level`
  String get lblTADFeeAtProgram {
    return Intl.message(
      'TAD fee at Program level',
      name: 'lblTADFeeAtProgram',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get lblDescription {
    return Intl.message(
      'Description',
      name: 'lblDescription',
      desc: '',
      args: [],
    );
  }

  /// `Make  Model`
  String get lblMakeModel {
    return Intl.message(
      'Make  Model',
      name: 'lblMakeModel',
      desc: '',
      args: [],
    );
  }

  /// `Vendor`
  String get lblVendor {
    return Intl.message('Vendor', name: 'lblVendor', desc: '', args: []);
  }

  /// `Billing Frequency`
  String get lblBillingFreq {
    return Intl.message(
      'Billing Frequency',
      name: 'lblBillingFreq',
      desc: '',
      args: [],
    );
  }

  /// `Fee Plan`
  String get lblFeePlan {
    return Intl.message('Fee Plan', name: 'lblFeePlan', desc: '', args: []);
  }

  /// `Define the applicable Merchant Transaction Fees at Program level`
  String get lblFeeTransactionDesc {
    return Intl.message(
      'Define the applicable Merchant Transaction Fees at Program level',
      name: 'lblFeeTransactionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Transaction Fee at Program Level`
  String get lblMerctTransactionDesc {
    return Intl.message(
      'Merchant Transaction Fee at Program Level',
      name: 'lblMerctTransactionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Apply to the following Transaction Category`
  String get lblApplyTransCat {
    return Intl.message(
      'Apply to the following Transaction Category',
      name: 'lblApplyTransCat',
      desc: '',
      args: [],
    );
  }

  /// `Aggregate`
  String get lblAggregate {
    return Intl.message('Aggregate', name: 'lblAggregate', desc: '', args: []);
  }

  /// `Value used for Billing`
  String get lblValUsedBilling {
    return Intl.message(
      'Value used for Billing',
      name: 'lblValUsedBilling',
      desc: '',
      args: [],
    );
  }

  /// `FEP`
  String get lblFEP {
    return Intl.message('FEP', name: 'lblFEP', desc: '', args: []);
  }

  /// `FEP Transaction`
  String get tabFEPTransaction {
    return Intl.message(
      'FEP Transaction',
      name: 'tabFEPTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Web API Transaction`
  String get tabWebAPITransaction {
    return Intl.message(
      'Web API Transaction',
      name: 'tabWebAPITransaction',
      desc: '',
      args: [],
    );
  }

  /// `M.App Transaction`
  String get tabMAppTransaction {
    return Intl.message(
      'M.App Transaction',
      name: 'tabMAppTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Define the FEP Transaction Plan at Program Level`
  String get lblFEPTranDesc {
    return Intl.message(
      'Define the FEP Transaction Plan at Program Level',
      name: 'lblFEPTranDesc',
      desc: '',
      args: [],
    );
  }

  /// `FEP Transaction Plan Setup at Program Level`
  String get lblFEPSetup {
    return Intl.message(
      'FEP Transaction Plan Setup at Program Level',
      name: 'lblFEPSetup',
      desc: '',
      args: [],
    );
  }

  /// `Apply to the following Message Type`
  String get lblApplyMessage {
    return Intl.message(
      'Apply to the following Message Type',
      name: 'lblApplyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Define the Web API Transaction Plan at Program Level`
  String get lblWebAPIDesc {
    return Intl.message(
      'Define the Web API Transaction Plan at Program Level',
      name: 'lblWebAPIDesc',
      desc: '',
      args: [],
    );
  }

  /// `Web API Transaction Plan Setup at Program Level`
  String get lblWebAPISetup {
    return Intl.message(
      'Web API Transaction Plan Setup at Program Level',
      name: 'lblWebAPISetup',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Source Provider`
  String get lblTranSrcProvider {
    return Intl.message(
      'Transaction Source Provider',
      name: 'lblTranSrcProvider',
      desc: '',
      args: [],
    );
  }

  /// `Define the Mobile App Transaction Plan at Program Level`
  String get lblMAppTransactionDesc {
    return Intl.message(
      'Define the Mobile App Transaction Plan at Program Level',
      name: 'lblMAppTransactionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mobile App Transaction Plan Setup at Program Level`
  String get lblMAppSetupPlanDesc {
    return Intl.message(
      'Mobile App Transaction Plan Setup at Program Level',
      name: 'lblMAppSetupPlanDesc',
      desc: '',
      args: [],
    );
  }

  /// `Statement Billing Cycle`
  String get lblStatementBillingCyc {
    return Intl.message(
      'Statement Billing Cycle',
      name: 'lblStatementBillingCyc',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get lblPrograms {
    return Intl.message('Programs', name: 'lblPrograms', desc: '', args: []);
  }

  /// `Program Block User`
  String get lblProgramBlockUser {
    return Intl.message(
      'Program Block User',
      name: 'lblProgramBlockUser',
      desc: '',
      args: [],
    );
  }

  /// `Effective Date`
  String get lblEffectiveDate {
    return Intl.message(
      'Effective Date',
      name: 'lblEffectiveDate',
      desc: '',
      args: [],
    );
  }

  /// `Reason to Block`
  String get lblReasonToBlock {
    return Intl.message(
      'Reason to Block',
      name: 'lblReasonToBlock',
      desc: '',
      args: [],
    );
  }

  /// `Remarks`
  String get lblRemarks {
    return Intl.message('Remarks', name: 'lblRemarks', desc: '', args: []);
  }

  /// `Created By`
  String get lblCreatedBy {
    return Intl.message('Created By', name: 'lblCreatedBy', desc: '', args: []);
  }

  /// `Status Change History`
  String get lblStatusChangeHistory {
    return Intl.message(
      'Status Change History',
      name: 'lblStatusChangeHistory',
      desc: '',
      args: [],
    );
  }

  /// `Pending Enrolment`
  String get lblPendingEnrolment {
    return Intl.message(
      'Pending Enrolment',
      name: 'lblPendingEnrolment',
      desc: '',
      args: [],
    );
  }

  /// `Pending Customer Enrolment`
  String get lblPendingCustEnrolment {
    return Intl.message(
      'Pending Customer Enrolment',
      name: 'lblPendingCustEnrolment',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get lblCustomer {
    return Intl.message('Customer', name: 'lblCustomer', desc: '', args: []);
  }

  /// `New Customer Enrolment. Please ensure all supporting documents are available before proceeding tot he enrolment process`
  String get lblCustEnrolDesc {
    return Intl.message(
      'New Customer Enrolment. Please ensure all supporting documents are available before proceeding tot he enrolment process',
      name: 'lblCustEnrolDesc',
      desc: '',
      args: [],
    );
  }

  /// `Customer Info`
  String get lblCustomerInfo {
    return Intl.message(
      'Customer Info',
      name: 'lblCustomerInfo',
      desc: '',
      args: [],
    );
  }

  /// `Application Info`
  String get lblApplicationInfo {
    return Intl.message(
      'Application Info',
      name: 'lblApplicationInfo',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration Name`
  String get lblBussnessName {
    return Intl.message(
      'Business Registration Name',
      name: 'lblBussnessName',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration No`
  String get lblBusnRegisNo {
    return Intl.message(
      'Business Registration No',
      name: 'lblBusnRegisNo',
      desc: '',
      args: [],
    );
  }

  /// `Person in Charge`
  String get lblPIC {
    return Intl.message('Person in Charge', name: 'lblPIC', desc: '', args: []);
  }

  /// `Name`
  String get lblName {
    return Intl.message('Name', name: 'lblName', desc: '', args: []);
  }

  /// `Designation`
  String get lblPosnHeld {
    return Intl.message('Designation', name: 'lblPosnHeld', desc: '', args: []);
  }

  /// `Choose one`
  String get lblChooseOne {
    return Intl.message('Choose one', name: 'lblChooseOne', desc: '', args: []);
  }

  /// `012 xxxxxxx`
  String get lblSampleMobileNo {
    return Intl.message(
      '012 xxxxxxx',
      name: 'lblSampleMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get lblEmailAddr {
    return Intl.message(
      'Email Address',
      name: 'lblEmailAddr',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get lblMobileNo {
    return Intl.message('Mobile No.', name: 'lblMobileNo', desc: '', args: []);
  }

  /// `Phone No.`
  String get lblPhoneNo {
    return Intl.message('Phone No.', name: 'lblPhoneNo', desc: '', args: []);
  }

  /// `Extension`
  String get lblExtension {
    return Intl.message('Extension', name: 'lblExtension', desc: '', args: []);
  }

  /// `Application Reference`
  String get lblApplRef {
    return Intl.message(
      'Application Reference',
      name: 'lblApplRef',
      desc: '',
      args: [],
    );
  }

  /// `Application Source`
  String get lblApplSrc {
    return Intl.message(
      'Application Source',
      name: 'lblApplSrc',
      desc: '',
      args: [],
    );
  }

  /// `Sumission Date`
  String get lblSubDate {
    return Intl.message(
      'Sumission Date',
      name: 'lblSubDate',
      desc: '',
      args: [],
    );
  }

  /// `Account Manager`
  String get lblAccMgr {
    return Intl.message(
      'Account Manager',
      name: 'lblAccMgr',
      desc: '',
      args: [],
    );
  }

  /// `Creation Date`
  String get lblCreationDate {
    return Intl.message(
      'Creation Date',
      name: 'lblCreationDate',
      desc: '',
      args: [],
    );
  }

  /// `Customer Hierarchy has...`
  String get lblCustHierachy {
    return Intl.message(
      'Customer Hierarchy has...',
      name: 'lblCustHierachy',
      desc: '',
      args: [],
    );
  }

  /// `Customer has signed up to...`
  String get lblCustSignUpto {
    return Intl.message(
      'Customer has signed up to...',
      name: 'lblCustSignUpto',
      desc: '',
      args: [],
    );
  }

  /// `Application Validation Check List...`
  String get lblApplValidationCheckDesc {
    return Intl.message(
      'Application Validation Check List...',
      name: 'lblApplValidationCheckDesc',
      desc: '',
      args: [],
    );
  }

  /// `Validate Application`
  String get lblValidateApplication {
    return Intl.message(
      'Validate Application',
      name: 'lblValidateApplication',
      desc: '',
      args: [],
    );
  }

  /// `Quick Info`
  String get tabQuickInfo {
    return Intl.message('Quick Info', name: 'tabQuickInfo', desc: '', args: []);
  }

  /// `Profile`
  String get tabProfile {
    return Intl.message('Profile', name: 'tabProfile', desc: '', args: []);
  }

  /// `Credit Risk Control`
  String get tabCreditRiskControl {
    return Intl.message(
      'Credit Risk Control',
      name: 'tabCreditRiskControl',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get tabDocuments {
    return Intl.message('Documents', name: 'tabDocuments', desc: '', args: []);
  }

  /// `Overview`
  String get tabOverview {
    return Intl.message('Overview', name: 'tabOverview', desc: '', args: []);
  }

  /// `Approval History`
  String get tabApprovalHistory {
    return Intl.message(
      'Approval History',
      name: 'tabApprovalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get tabAddress {
    return Intl.message('Address', name: 'tabAddress', desc: '', args: []);
  }

  /// `Contact`
  String get tabContact {
    return Intl.message('Contact', name: 'tabContact', desc: '', args: []);
  }

  /// `Director`
  String get tabDirector {
    return Intl.message('Director', name: 'tabDirector', desc: '', args: []);
  }

  /// `Date of Incorporation`
  String get lblDateOfInc {
    return Intl.message(
      'Date of Incorporation',
      name: 'lblDateOfInc',
      desc: '',
      args: [],
    );
  }

  /// `Type of Company`
  String get lblTypeOfCompany {
    return Intl.message(
      'Type of Company',
      name: 'lblTypeOfCompany',
      desc: '',
      args: [],
    );
  }

  /// `Nature of Business`
  String get lblNatureOfBusn {
    return Intl.message(
      'Nature of Business',
      name: 'lblNatureOfBusn',
      desc: '',
      args: [],
    );
  }

  /// `Web API Transaction`
  String get tabWebApiTransaction {
    return Intl.message(
      'Web API Transaction',
      name: 'tabWebApiTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Program Setup`
  String get lblProgramSetup {
    return Intl.message(
      'Program Setup',
      name: 'lblProgramSetup',
      desc: '',
      args: [],
    );
  }

  /// `Credit Risk Setting`
  String get tabCreditRiskSetting {
    return Intl.message(
      'Credit Risk Setting',
      name: 'tabCreditRiskSetting',
      desc: '',
      args: [],
    );
  }

  /// `Security Deposits`
  String get tabSecurityDeposit {
    return Intl.message(
      'Security Deposits',
      name: 'tabSecurityDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get tabApplication {
    return Intl.message(
      'Application',
      name: 'tabApplication',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Statement`
  String get tabInvStatement {
    return Intl.message(
      'Invoice Statement',
      name: 'tabInvStatement',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get tabStatement {
    return Intl.message('Statement', name: 'tabStatement', desc: '', args: []);
  }

  /// `Communication`
  String get tabCommunication {
    return Intl.message(
      'Communication',
      name: 'tabCommunication',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get tabBank {
    return Intl.message('Bank', name: 'tabBank', desc: '', args: []);
  }

  /// `Subsidy Quota`
  String get tabSubsidyQuota {
    return Intl.message(
      'Subsidy Quota',
      name: 'tabSubsidyQuota',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get tabCustomer {
    return Intl.message('Customer', name: 'tabCustomer', desc: '', args: []);
  }

  /// `Company`
  String get tabCompany {
    return Intl.message('Company', name: 'tabCompany', desc: '', args: []);
  }

  /// `Cost Center`
  String get tabCostCenter {
    return Intl.message(
      'Cost Center',
      name: 'tabCostCenter',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get tabMember {
    return Intl.message('Member', name: 'tabMember', desc: '', args: []);
  }

  /// `Location`
  String get tabLocation {
    return Intl.message('Location', name: 'tabLocation', desc: '', args: []);
  }

  /// `Quota`
  String get tabQuota {
    return Intl.message('Quota', name: 'tabQuota', desc: '', args: []);
  }

  /// `Billing Account`
  String get tabBillingAccount {
    return Intl.message(
      'Billing Account',
      name: 'tabBillingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Pending Bulk Order`
  String get lblPendingBulkOrder {
    return Intl.message(
      'Pending Bulk Order',
      name: 'lblPendingBulkOrder',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus Users`
  String get sbNucleusUsers {
    return Intl.message(
      'Nucleus Users',
      name: 'sbNucleusUsers',
      desc: '',
      args: [],
    );
  }

  /// `Web Portal Users`
  String get sbWebPortalUsers {
    return Intl.message(
      'Web Portal Users',
      name: 'sbWebPortalUsers',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus Access Control`
  String get sbNucleusAccessControl {
    return Intl.message(
      'Nucleus Access Control',
      name: 'sbNucleusAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Web Access Control`
  String get sbNucleusWebAccessControl {
    return Intl.message(
      'Web Access Control',
      name: 'sbNucleusWebAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Cost Center Info`
  String get lblCostCenterInfo {
    return Intl.message(
      'Cost Center Info',
      name: 'lblCostCenterInfo',
      desc: '',
      args: [],
    );
  }

  /// `Hierarchy Group`
  String get lblHierarchyGroup {
    return Intl.message(
      'Hierarchy Group',
      name: 'lblHierarchyGroup',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get tabMembership {
    return Intl.message(
      'Membership',
      name: 'tabMembership',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get tabPersonalInfo {
    return Intl.message(
      'Personal Info',
      name: 'tabPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Info`
  String get tabVehicleInfo {
    return Intl.message(
      'Vehicle Info',
      name: 'tabVehicleInfo',
      desc: '',
      args: [],
    );
  }

  /// `Member Info`
  String get tabMemberInfo {
    return Intl.message(
      'Member Info',
      name: 'tabMemberInfo',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get lblFirstName {
    return Intl.message('First Name', name: 'lblFirstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lblLastname {
    return Intl.message('Last Name', name: 'lblLastname', desc: '', args: []);
  }

  /// `Type of ID`
  String get lblTypeOfId {
    return Intl.message('Type of ID', name: 'lblTypeOfId', desc: '', args: []);
  }

  /// `ID Number`
  String get lblIDNumber {
    return Intl.message('ID Number', name: 'lblIDNumber', desc: '', args: []);
  }

  /// `Employee Number`
  String get lblEmployeeNumber {
    return Intl.message(
      'Employee Number',
      name: 'lblEmployeeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Employee Start Date`
  String get lblEmployeeStartDate {
    return Intl.message(
      'Employee Start Date',
      name: 'lblEmployeeStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Details`
  String get lblVehicleDatails {
    return Intl.message(
      'Vehicle Details',
      name: 'lblVehicleDatails',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Registration Number`
  String get lblVehicleRegNo {
    return Intl.message(
      'Vehicle Registration Number',
      name: 'lblVehicleRegNo',
      desc: '',
      args: [],
    );
  }

  /// `Brand  Maker`
  String get lblVehBrandMake {
    return Intl.message(
      'Brand  Maker',
      name: 'lblVehBrandMake',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get lblVehModel {
    return Intl.message('Model', name: 'lblVehModel', desc: '', args: []);
  }

  /// `Type of Vehicle`
  String get lblVehType {
    return Intl.message(
      'Type of Vehicle',
      name: 'lblVehType',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Class`
  String get lblVehClass {
    return Intl.message(
      'Vehicle Class',
      name: 'lblVehClass',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Registration Date`
  String get lblVehRgsDate {
    return Intl.message(
      'Vehicle Registration Date',
      name: 'lblVehRgsDate',
      desc: '',
      args: [],
    );
  }

  /// `Product Acceptance`
  String get tabProdAccpt {
    return Intl.message(
      'Product Acceptance',
      name: 'tabProdAccpt',
      desc: '',
      args: [],
    );
  }

  /// `Type of Limit`
  String get lblTypeOfLimit {
    return Intl.message(
      'Type of Limit',
      name: 'lblTypeOfLimit',
      desc: '',
      args: [],
    );
  }

  /// `Limit Measurement apply to`
  String get lblLimitMeaApplyTo {
    return Intl.message(
      'Limit Measurement apply to',
      name: 'lblLimitMeaApplyTo',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get lblMin {
    return Intl.message('Min', name: 'lblMin', desc: '', args: []);
  }

  /// `Max`
  String get lblMax {
    return Intl.message('Max', name: 'lblMax', desc: '', args: []);
  }

  /// `Count`
  String get lblCount {
    return Intl.message('Count', name: 'lblCount', desc: '', args: []);
  }

  /// `Card Properties`
  String get tabMediaProperties {
    return Intl.message(
      'Card Properties',
      name: 'tabMediaProperties',
      desc: '',
      args: [],
    );
  }

  /// `Card Design`
  String get tabCardDesign {
    return Intl.message(
      'Card Design',
      name: 'tabCardDesign',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder`
  String get tabMediaHolder {
    return Intl.message(
      'Card Holder',
      name: 'tabMediaHolder',
      desc: '',
      args: [],
    );
  }

  /// `Subsidy Program Management`
  String get lblSubPrgMgmt {
    return Intl.message(
      'Subsidy Program Management',
      name: 'lblSubPrgMgmt',
      desc: '',
      args: [],
    );
  }

  /// `Subsidy Rate`
  String get tabSubsidyRate {
    return Intl.message(
      'Subsidy Rate',
      name: 'tabSubsidyRate',
      desc: '',
      args: [],
    );
  }

  /// `Check List`
  String get tabCustEnrollCheckList {
    return Intl.message(
      'Check List',
      name: 'tabCustEnrollCheckList',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get tabSubscription {
    return Intl.message(
      'Subscription',
      name: 'tabSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Select CardHolder`
  String get tabSelectMediaHolder {
    return Intl.message(
      'Select CardHolder',
      name: 'tabSelectMediaHolder',
      desc: '',
      args: [],
    );
  }

  /// `Road Tax Expiry`
  String get lblRoadTaxExp {
    return Intl.message(
      'Road Tax Expiry',
      name: 'lblRoadTaxExp',
      desc: '',
      args: [],
    );
  }

  /// `Engine Capacity`
  String get lblEngineCapacity {
    return Intl.message(
      'Engine Capacity',
      name: 'lblEngineCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Account Setting`
  String get tabAccountSetting {
    return Intl.message(
      'Account Setting',
      name: 'tabAccountSetting',
      desc: '',
      args: [],
    );
  }

  /// `Pending Merchant Enrolment`
  String get lblPendingMchtEnrl {
    return Intl.message(
      'Pending Merchant Enrolment',
      name: 'lblPendingMchtEnrl',
      desc: '',
      args: [],
    );
  }

  /// `Merchant`
  String get tabMerchant {
    return Intl.message('Merchant', name: 'tabMerchant', desc: '', args: []);
  }

  /// `Business Unit`
  String get tabBusinessUnit {
    return Intl.message(
      'Business Unit',
      name: 'tabBusinessUnit',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Acceptance`
  String get tabTranAccpt {
    return Intl.message(
      'Transaction Acceptance',
      name: 'tabTranAccpt',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Management`
  String get lblMerchantManagement {
    return Intl.message(
      'Merchant Management',
      name: 'lblMerchantManagement',
      desc: '',
      args: [],
    );
  }

  /// `Change Location Status`
  String get tabChangeLocationStatus {
    return Intl.message(
      'Change Location Status',
      name: 'tabChangeLocationStatus',
      desc: '',
      args: [],
    );
  }

  /// `AppWeb Users`
  String get tabAppWebUsers {
    return Intl.message(
      'AppWeb Users',
      name: 'tabAppWebUsers',
      desc: '',
      args: [],
    );
  }

  /// `Add App/Web Users`
  String get tabAddAppWebUsers {
    return Intl.message(
      'Add App/Web Users',
      name: 'tabAddAppWebUsers',
      desc: '',
      args: [],
    );
  }

  /// `Settlement`
  String get tabSettlement {
    return Intl.message(
      'Settlement',
      name: 'tabSettlement',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get tabAccount {
    return Intl.message('Account', name: 'tabAccount', desc: '', args: []);
  }

  /// `lblPendingCustMgmtment`
  String get lblPendingCustMgmtment {
    return Intl.message(
      'lblPendingCustMgmtment',
      name: 'lblPendingCustMgmtment',
      desc: '',
      args: [],
    );
  }

  /// `Cust Management Check List`
  String get tabCustMgmtCheckList {
    return Intl.message(
      'Cust Management Check List',
      name: 'tabCustMgmtCheckList',
      desc: '',
      args: [],
    );
  }

  /// `Events & Notes`
  String get tabEventAndNotes {
    return Intl.message(
      'Events & Notes',
      name: 'tabEventAndNotes',
      desc: '',
      args: [],
    );
  }

  /// `Post Paid`
  String get tabPostPaid {
    return Intl.message('Post Paid', name: 'tabPostPaid', desc: '', args: []);
  }

  /// `Credit Evaluation`
  String get tabCreditEvaluation {
    return Intl.message(
      'Credit Evaluation',
      name: 'tabCreditEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `Credit Risk Assessment`
  String get tabCreditAssessment {
    return Intl.message(
      'Credit Risk Assessment',
      name: 'tabCreditAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Manual Transaction`
  String get tabDataEntryManual {
    return Intl.message(
      'Manual Transaction',
      name: 'tabDataEntryManual',
      desc: '',
      args: [],
    );
  }

  /// `Reimbursement`
  String get tabReimburseMent {
    return Intl.message(
      'Reimbursement',
      name: 'tabReimburseMent',
      desc: '',
      args: [],
    );
  }

  /// `Card Info`
  String get tabMediaInfo {
    return Intl.message('Card Info', name: 'tabMediaInfo', desc: '', args: []);
  }

  /// `Card Renewal`
  String get tabMediaRenewal {
    return Intl.message(
      'Card Renewal',
      name: 'tabMediaRenewal',
      desc: '',
      args: [],
    );
  }

  /// `Card Reissue/Replace`
  String get tabMediaReissue {
    return Intl.message(
      'Card Reissue/Replace',
      name: 'tabMediaReissue',
      desc: '',
      args: [],
    );
  }

  /// `Card Renewal Search`
  String get tabMediaRenewSearch {
    return Intl.message(
      'Card Renewal Search',
      name: 'tabMediaRenewSearch',
      desc: '',
      args: [],
    );
  }

  /// `Limit Value`
  String get lblLimitValue {
    return Intl.message(
      'Limit Value',
      name: 'lblLimitValue',
      desc: '',
      args: [],
    );
  }

  /// `Program Acceptance`
  String get tabProgramAcceptance {
    return Intl.message(
      'Program Acceptance',
      name: 'tabProgramAcceptance',
      desc: '',
      args: [],
    );
  }

  /// `ScreenList`
  String get screenList {
    return Intl.message('ScreenList', name: 'screenList', desc: '', args: []);
  }

  /// `Change Credit Expiry`
  String get changeCreditLimit {
    return Intl.message(
      'Change Credit Expiry',
      name: 'changeCreditLimit',
      desc: '',
      args: [],
    );
  }

  /// `On-Screen Reports`
  String get onScreenReports {
    return Intl.message(
      'On-Screen Reports',
      name: 'onScreenReports',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled Reports`
  String get scheduledReports {
    return Intl.message(
      'Scheduled Reports',
      name: 'scheduledReports',
      desc: '',
      args: [],
    );
  }

  /// `Audit Log`
  String get auditLog {
    return Intl.message('Audit Log', name: 'auditLog', desc: '', args: []);
  }

  /// `Page Tracking Log`
  String get pageTracking {
    return Intl.message(
      'Page Tracking Log',
      name: 'pageTracking',
      desc: '',
      args: [],
    );
  }

  /// `Bulk Order History`
  String get bulkOrderHistory {
    return Intl.message(
      'Bulk Order History',
      name: 'bulkOrderHistory',
      desc: '',
      args: [],
    );
  }

  /// `New Bulk Order`
  String get newBulkOrder {
    return Intl.message(
      'New Bulk Order',
      name: 'newBulkOrder',
      desc: '',
      args: [],
    );
  }

  /// `New Enrolment`
  String get newB2BEnrollMent {
    return Intl.message(
      'New Enrolment',
      name: 'newB2BEnrollMent',
      desc: '',
      args: [],
    );
  }

  /// `New Subsidy Program`
  String get newSubsidyProgram {
    return Intl.message(
      'New Subsidy Program',
      name: 'newSubsidyProgram',
      desc: '',
      args: [],
    );
  }

  /// `New Program`
  String get newProgram {
    return Intl.message('New Program', name: 'newProgram', desc: '', args: []);
  }

  /// `Pending Bulk Order`
  String get pendingBulkOrder {
    return Intl.message(
      'Pending Bulk Order',
      name: 'pendingBulkOrder',
      desc: '',
      args: [],
    );
  }

  /// `Access Group`
  String get sbUserGroup {
    return Intl.message(
      'Access Group',
      name: 'sbUserGroup',
      desc: '',
      args: [],
    );
  }

  /// `Web Group`
  String get sbWebGroup {
    return Intl.message('Web Group', name: 'sbWebGroup', desc: '', args: []);
  }

  /// `cClick CMS Upload`
  String get sbCMSUpload {
    return Intl.message(
      'cClick CMS Upload',
      name: 'sbCMSUpload',
      desc: '',
      args: [],
    );
  }

  /// `PUKAL Billing Process`
  String get sbPukalBillingProcess {
    return Intl.message(
      'PUKAL Billing Process',
      name: 'sbPukalBillingProcess',
      desc: '',
      args: [],
    );
  }

  /// `PUKAL Reports`
  String get sbPukalReport {
    return Intl.message(
      'PUKAL Reports',
      name: 'sbPukalReport',
      desc: '',
      args: [],
    );
  }

  /// `Site Settings`
  String get sbSiteSettings {
    return Intl.message(
      'Site Settings',
      name: 'sbSiteSettings',
      desc: '',
      args: [],
    );
  }

  /// `Outbound`
  String get sbOutbound {
    return Intl.message('Outbound', name: 'sbOutbound', desc: '', args: []);
  }

  /// `Inbound`
  String get sbInbound {
    return Intl.message('Inbound', name: 'sbInbound', desc: '', args: []);
  }

  /// `Pukal`
  String get tabPukal {
    return Intl.message('Pukal', name: 'tabPukal', desc: '', args: []);
  }

  /// `Card Balance`
  String get tabCardBalance {
    return Intl.message(
      'Card Balance',
      name: 'tabCardBalance',
      desc: '',
      args: [],
    );
  }

  /// `OLTP Rejection`
  String get menuQueryOLTP {
    return Intl.message(
      'OLTP Rejection',
      name: 'menuQueryOLTP',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ms', countryCode: 'MY'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
