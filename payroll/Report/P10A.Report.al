// report 70135118 "P.10 A"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './P10A.rdlc';

//     dataset
//     {
//         dataitem(DataItem6207; 61118)
//         {
//             DataItemTableView = SORTING (Employee Code)
//                                 ORDER(Ascending);
//             column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
//             {
//             }
//             column(CompanySetup__Company_P_I_N_; CompanySetup."Company P.I.N")
//             {
//             }
//             column(YR; YR)
//             {
//             }
//             column(Employee_Payroll___First_Name_______Employee_Payroll___Middle_Name_______Employee_Payroll___Last_Name_; "Employee Payroll"."First Name" + ' ' + "Employee Payroll"."Middle Name" + ' ' + "Employee Payroll"."Last Name")
//             {
//             }
//             column(GrossPay; GrossPay)
//             {
//             }
//             column(ABS_MyPAYE_; ABS(MyPAYE))
//             {
//             }
//             column(Employee_Payroll___PIN_Number_; "Employee Payroll"."PIN Number")
//             {
//             }
//             column(ABS_MyPAYE__Control1102756065; ABS(MyPAYE))
//             {
//             }
//             column(GrossPay_Control1102756086; GrossPay)
//             {
//             }
//             column(ABS_MyPAYE__Control1102756092; ABS(MyPAYE))
//             {
//             }
//             column(GrossPay_Control1102756113; GrossPay)
//             {
//             }
//             column(PAYE_DEDUCTED_KSHS_Caption; PAYE_DEDUCTED_KSHS_CaptionLbl)
//             {
//             }
//             column(TOTAL_EMOLUMENTS_KSHS_Caption; TOTAL_EMOLUMENTS_KSHS_CaptionLbl)
//             {
//             }
//             column(EMPLOYEE_S_NAMECaption; EMPLOYEE_S_NAMECaptionLbl)
//             {
//             }
//             column(EmptyStringCaption; EmptyStringCaptionLbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102756009; EmptyStringCaption_Control1102756009Lbl)
//             {
//             }
//             column(EMPLOYER_S_NAMECaption; EMPLOYER_S_NAMECaptionLbl)
//             {
//             }
//             column(EMPLOYER_S_PINCaption; EMPLOYER_S_PINCaptionLbl)
//             {
//             }
//             column(P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaption; P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaptionLbl)
//             {
//             }
//             column(EMPLOYEE_S_PINCaption; EMPLOYEE_S_PINCaptionLbl)
//             {
//             }
//             column(P_10ACaption; P_10ACaptionLbl)
//             {
//             }
//             column(APPENDIX_5ACaption; APPENDIX_5ACaptionLbl)
//             {
//             }
//             column(DOMESTIC_TAXES_DEPARTMENTCaption; DOMESTIC_TAXES_DEPARTMENTCaptionLbl)
//             {
//             }
//             column(ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption; ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_CaptionLbl)
//             {
//             }
//             column(DELETE_AS_APPROPRIATECaption; DELETE_AS_APPROPRIATECaptionLbl)
//             {
//             }
//             column(NOTE_TO_EMPLOYER_Caption; NOTE_TO_EMPLOYER_CaptionLbl)
//             {
//             }
//             column(TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption; TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaptionLbl)
//             {
//             }
//             column(TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption; TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaptionLbl)
//             {
//             }
//             column(TOTAL_WCPSCaption; TOTAL_WCPSCaptionLbl)
//             {
//             }
//             column(TOTAL_PAYE_TAXCaption; TOTAL_PAYE_TAXCaptionLbl)
//             {
//             }
//             column(TOTAL_EMOLUMENTSCaption; TOTAL_EMOLUMENTSCaptionLbl)
//             {
//             }
//             column(ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087; ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087Lbl)
//             {
//             }
//             column(DELETE_AS_APPROPRIATECaption_Control1102756088; DELETE_AS_APPROPRIATECaption_Control1102756088Lbl)
//             {
//             }
//             column(TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091; TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091Lbl)
//             {
//             }
//             column(NOTE_TO_EMPLOYER_Caption_Control1102756095; NOTE_TO_EMPLOYER_Caption_Control1102756095Lbl)
//             {
//             }
//             column(TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096; TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096Lbl)
//             {
//             }
//             column(TOTAL_WCPSCaption_Control1102756103; TOTAL_WCPSCaption_Control1102756103Lbl)
//             {
//             }
//             column(TOTAL_PAYE_TAXCaption_Control1102756107; TOTAL_PAYE_TAXCaption_Control1102756107Lbl)
//             {
//             }
//             column(TOTAL_EMOLUMENTSCaption_Control1102756112; TOTAL_EMOLUMENTSCaption_Control1102756112Lbl)
//             {
//             }
//             column(prSalary_Card_Employee_Code; "Employee Code")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 IF "Employee Payroll".GET("prSalary Card"."Employee Code") THEN BEGIN

//                 END;

//                 MyPAYE := 0;
//                 GrossPay := 0;
//                 "prSalary Card".CALCFIELDS("prSalary Card"."Cumm PAYE");
//                 "prSalary Card".CALCFIELDS("prSalary Card"."Cumm Allowances", "prSalary Card"."Cumm BasicPay");
//                 "prSalary Card".CALCFIELDS("prSalary Card"."Cumm GrossPay");
//                 PAYE := ABS("prSalary Card"."Cumm PAYE");
//                 TotalCumm := TotalCumm + ABS("prSalary Card"."Cumm PAYE");
//                 MyPAYE := "prSalary Card"."Cumm PAYE";

//                 IF ABS("prSalary Card"."Cumm PAYE") > 0 THEN BEGIN
//                     GrossPay := "prSalary Card"."Cumm GrossPay";
//                     Index := Index + 1;
//                 END;
//                 CurrReport.CREATETOTALS(MyPAYE, GrossPay);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 "prSalary Card".SETRANGE("prSalary Card"."Period Filter", StringDate, EndDate);
//                 YR := DATE2DMY(StringDate, 3);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(strtDate; StringDate)
//                 {
//                     Caption = 'Start Date';
//                     TableRelation = "prPayroll Periods"."Date Opened";
//                 }
//                 field(enddates; EndDate)
//                 {
//                     Caption = 'End Date';
//                     TableRelation = "prPayroll Periods"."Date Opened";
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         StringDate: Date;
//         EndDate: Date;
//         PAYE: Decimal;
//         TotPAYE: Decimal;
//         CompanySetup: Record 79;
//         YR: Integer;
//         TotalCumm: Decimal;
//         Index: Integer;
//         TotPayeTemp: Decimal;
//         EmpLedgerentry: Record "70134960";
//         GrossPay: Decimal;
//         EmpCalc: Record "70134973";
//         MyPAYE: Decimal;
//         MyPAYETot: Decimal;
//         MyPGROSSTot: Decimal;
//         "Employee Payroll": Record "70134986";
//         PAYE_DEDUCTED_KSHS_CaptionLbl: Label 'PAYE DEDUCTED KSHS.';
//         TOTAL_EMOLUMENTS_KSHS_CaptionLbl: Label 'TOTAL EMOLUMENTS KSHS.';
//         EMPLOYEE_S_NAMECaptionLbl: Label 'EMPLOYEE''S NAME';
//         EmptyStringCaptionLbl: Label '...........................................................';
//         EmptyStringCaption_Control1102756009Lbl: Label '...........................................................';
//         EMPLOYER_S_NAMECaptionLbl: Label 'EMPLOYER''S NAME';
//         EMPLOYER_S_PINCaptionLbl: Label 'EMPLOYER''S PIN';
//         P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaptionLbl: Label 'P.A.Y.E SUPPORTING LIST FOR END OF YEAR CERTIFICATE: YEAR';
//         EMPLOYEE_S_PINCaptionLbl: Label 'EMPLOYEE''S PIN';
//         P_10ACaptionLbl: Label 'P.10A';
//         APPENDIX_5ACaptionLbl: Label 'APPENDIX 5A';
//         DOMESTIC_TAXES_DEPARTMENTCaptionLbl: Label 'DOMESTIC TAXES DEPARTMENT';
//         ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_CaptionLbl: Label 'ATTACH TWO COPIES OF THIS LIST TO END OF YEAR CERTIFICATE (P10)';
//         DELETE_AS_APPROPRIATECaptionLbl: Label '*DELETE AS APPROPRIATE';
//         NOTE_TO_EMPLOYER_CaptionLbl: Label 'NOTE TO EMPLOYER:';
//         TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaptionLbl: Label '*TOTAL TAX DEDUCTED/ TOTAL C/F TO NEXT LIST';
//         TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaptionLbl: Label '*TAX ON LUMP SUM/ AUDIT/ INTEREST / PENALTY';
//         TOTAL_WCPSCaptionLbl: Label 'TOTAL WCPS';
//         TOTAL_PAYE_TAXCaptionLbl: Label 'TOTAL PAYE TAX';
//         TOTAL_EMOLUMENTSCaptionLbl: Label 'TOTAL EMOLUMENTS';
//         ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087Lbl: Label 'ATTACH TWO COPIES OF THIS LIST TO END OF YEAR CERTIFICATE (P10)';
//         DELETE_AS_APPROPRIATECaption_Control1102756088Lbl: Label '*DELETE AS APPROPRIATE';
//         TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091Lbl: Label '*TOTAL TAX DEDUCTED/ TOTAL C/F TO NEXT LIST';
//         NOTE_TO_EMPLOYER_Caption_Control1102756095Lbl: Label 'NOTE TO EMPLOYER:';
//         TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096Lbl: Label '*TAX ON LUMP SUM/ AUDIT/ INTEREST / PENALTY';
//         TOTAL_WCPSCaption_Control1102756103Lbl: Label 'TOTAL WCPS';
//         TOTAL_PAYE_TAXCaption_Control1102756107Lbl: Label 'TOTAL PAYE TAX';
//         TOTAL_EMOLUMENTSCaption_Control1102756112Lbl: Label 'TOTAL EMOLUMENTS';
// }

