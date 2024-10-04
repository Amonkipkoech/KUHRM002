// report 70083 "PRL-Cummulative Allowances"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Payroll/Report/SSR/PRLCummulativeAllowances.rdl';

//     dataset
//     {
//         dataitem(DataItem1; "PRL-Period Transactions")
//         {
//             DataItemTableView = WHERE("Group Order" = FILTER(1 | 3 | 4));
//             RequestFilterFields = "Transaction Code";
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102755015; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756027; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756028; COMPANYNAME)
//             {
//             }
//             column(CompanyInfo_Picture; CompanyInfo.Picture)
//             {
//             }
//             column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
//             {
//             }
//             column(PayrollSummary; 'COMPANY PAYROLL SUMMARY')
//             {
//             }
//             column(PeriodNamez; 'PERIOD:  ' + PeriodName)
//             {
//             }
//             column(TransDesc; 'TRANSACTION DESC.')
//             {
//             }
//             column(payments; 'PAYMENTS')
//             {
//             }
//             column(deductions; 'DEDUCTIONS')
//             {
//             }
//             column(kirinyagatitle; COMPANYNAME)
//             {
//             }
//             column(abreviation; 'MUST')
//             {
//             }
//             column(EmpNo; "PRL-Period Transactions"."Employee Code")
//             {
//             }
//             column(empName; empName)
//             {
//             }
//             column(EmpAmount; "PRL-Period Transactions".Amount)
//             {
//             }
//             column("code"; "PRL-Period Transactions"."Transaction Code")
//             {
//             }
//             column(name; "PRL-Period Transactions"."Transaction Name")
//             {
//             }
//             column(Transaction; "PRL-Period Transactions"."Transaction Code" + ': ' + "PRL-Period Transactions"."Transaction Name")
//             {
//             }
//             column(TotLabel; "PRL-Period Transactions"."Transaction Code" + ': ' + "PRL-Period Transactions"."Transaction Name")
//             {
//             }
//             column(IDNumber; emps."ID Number")
//             {
//             }
//             column(PeriodName2; objPeriod2."Period Name")
//             {
//             }
//             column(PeriodDate2; objPeriod2."Date Opened")
//             {
//             }
//             column(PeriodDate; objPeriod."Date Opened")
//             {
//             }
//             column(PeriodName; objPeriod."Period Name")
//             {
//             }
//             column(PerOpenned; "prPayroll Periods"."Date Opened")
//             {
//             }
//             column(PerName; "prPayroll Periods"."Period Name")
//             {
//             }
//             column(go; "PRL-Period Transactions"."Group Order")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "prPayroll Periods".RESET;
//                 "prPayroll Periods".SETRANGE("prPayroll Periods"."Date Opened", "PRL-Period Transactions"."Payroll Period");
//                 IF "prPayroll Periods".FIND('-') THEN BEGIN
//                 END;

//                 CLEAR(empName);
//                 IF emps.GET("PRL-Period Transactions"."Employee Code") THEN
//                     empName := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
//             end;

//             trigger OnPreDataItem()
//             begin

//                 "PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period", '%1..%2', PeriodFilter, PeriodFilter2);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(periodfilter; PeriodFilter)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Start';
//                     TableRelation = "PRL-Payroll Periods"."Date Opened";
//                 }
//                 field(PeriodFilter2; PeriodFilter2)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'End';
//                     TableRelation = "PRL-Payroll Periods"."Date Closed";
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

//     trigger OnInitReport()
//     begin
//         objPeriod.RESET;
//         objPeriod.SETRANGE(objPeriod.Closed, FALSE);
//         IF objPeriod.FIND('-') THEN;
//         PeriodFilter2 := objPeriod."Date Opened";
//     end;

//     trigger OnPreReport()
//     begin
//         IF PeriodFilter > PeriodFilter2 THEN ERROR('Period Start is greater than period end.');
//         IF PeriodFilter = 0D THEN ERROR('Specify a Period!');
//         SelectedPeriod := PeriodFilter;
//         objPeriod.RESET;
//         objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
//         IF objPeriod.FIND('-') THEN BEGIN
//             PeriodFilter := objPeriod."Date Opened"
//         END;

//         SelectedPeriod2 := PeriodFilter2;
//         objPeriod2.RESET;
//         objPeriod2.SETRANGE(objPeriod2."Date Opened", SelectedPeriod2);
//         IF objPeriod2.FIND('-') THEN BEGIN
//             PeriodFilter2 := objPeriod2."Date Closed";
//         END;

//         IF CompanyInfo.GET() THEN
//             CLEAR(rows);
//         CLEAR(GPY);
//         CLEAR(STAT);
//         CLEAR(DED);
//         CLEAR(NETS);
//     end;

//     var
//         "PRL-Period Transactions": record "PRL-Period Transactions";
//         empName: Text[250];
//         found: Boolean;
//         countz: Integer;
//         PeriodFilter: Date;
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         PeriodTrans: Record "PRL-Period Transactions";
//         objPeriod: Record "PRL-Payroll Periods";
//         SelectedPeriod: Date;
//         PeriodName: Text[30];
//         PeriodFilter2: Date;
//         objPeriod2: Record "PRL-Payroll Periods";
//         SelectedPeriod2: Date;
//         PeriodName2: Text[30];
//         CompanyInfo: Record "Company Information";
//         TotalsAllowances: Decimal;
//         Dept: Boolean;
//         PaymentDesc: Text[200];
//         DeductionDesc: Text[200];
//         GroupText1: Text[200];
//         GroupText2: Text[200];
//         PaymentAmount: Decimal;
//         DeductAmount: Decimal;
//         PayTrans: array[70] of Text[250];
//         PayTransAmt: array[70] of Decimal;
//         DedTrans: array[70] of Text[250];
//         DedTransAmt: array[70] of Decimal;
//         rows: Integer;
//         rows2: Integer;
//         GPY: Decimal;
//         NETS: Decimal;
//         STAT: Decimal;
//         DED: Decimal;
//         TotalFor: Label 'Total for ';
//         GroupOrder: Label '3';
//         TransBal: array[2, 60] of Text[250];
//         Addr: array[2, 10] of Text[250];
//         RecordNo: Integer;
//         NoOfColumns: Integer;
//         ColumnNo: Integer;
//         emps: Record "HRM-Employee C";
//         "prPayroll Periods": Record "PRL-Payroll Periods";
// }

