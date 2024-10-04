// report 50946 "Payroll Variance Report 2"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './payroll/Report/SSR/Payroll Variance Report Two.rdl';

//     dataset
//     {
//         dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
//         {
//             DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order") ORDER(Ascending) WHERE("Group Order" = FILTER(<> 6));

//             column(USERID; UserId)
//             {
//             }
//             column(TODAY; Today)
//             {
//             }
//             column(PerName; objPeriod."Period Name")
//             {
//             }
//             column(PayPer; "PRL-Period Transactions"."Payroll Period")
//             {
//             }
//             column(CurrPerName; PeriodName1)
//             {
//             }
//             column(PrevPerName; PeriodName2)
//             {
//             }
//             column(PeriodFilters; "PRL-Period Transactions"."Payroll Period")
//             {
//             }
//             column(Currperiod; objPeriod."Date Opened")
//             { }
//             column(Prevperiod; objPeriod."Date Closed")
//             { }
//             column(PrevAmount; PeriodTrans1.Amount)
//             {
//             }
//             column(TransAmount; "PRL-Period Transactions".Amount)
//             {
//             }
//             column(pic; companyinfo.Picture)
//             {
//             }
//             column(compname; companyinfo.Name)
//             { }
//             column(compadress; companyinfo.Address)
//             { }
//             column(compphone; companyinfo."Phone No.")
//             { }
//             column(compwebpage; companyinfo."Home Page")
//             { }
//             column(compemail; companyinfo."E-Mail")
//             { }
//             column(Gtext; "PRL-Period Transactions"."Group Text")
//             {
//             }
//             column(EmpCode; "PRL-Period Transactions"."Employee Code")
//             {
//             }
//             column(TransCode; "PRL-Period Transactions"."Transaction Code")
//             {
//             }
//             column(TransName; UpperCase("PRL-Period Transactions"."Transaction Name"))
//             {
//             }
//             column(VarianceAmount; "PRL-Period Transactions".Amount - PeriodTrans1.Amount)
//             {
//             }
//             column(GO; "PRL-Period Transactions"."Group Order")
//             {
//             }
//             column(SGO; "PRL-Period Transactions"."Sub Group Order")
//             {
//             }
//             column(EmployeeName; EmployeeName)
//             {
//             }
//             column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(seq; seq)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 seq := seq + 1;
//                 objEmp.Reset;
//                 objEmp.SetRange(objEmp."No.", "PRL-Period Transactions"."Employee Code");
//                 if objEmp.Find('-') then
//                     EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
//                 Clear(statAmount);

//                 PeriodTrans1.Reset;
//                 PeriodTrans1.SetRange(PeriodTrans1."Employee Code", "PRL-Period Transactions"."Employee Code");
//                 PeriodTrans1.SetRange(PeriodTrans1."Transaction Code", "PRL-Period Transactions"."Transaction Code");
//                 PeriodTrans1.SetRange(PeriodTrans1."Payroll Period", EndPeriods);
//                 if PeriodTrans1.Find('-') then begin

//                 end;
//                 objPeriod.Reset;
//                 if objPeriod.Get("PRL-Period Transactions"."Payroll Period") then
//                     if "PRL-Period Transactions"."Transaction Code" = 'BPAY' then "PRL-Period Transactions"."Transaction Name" := 'BASIC';
//                 if "PRL-Period Transactions"."Transaction Code" = 'GPAY' then "PRL-Period Transactions"."Transaction Name" := 'GROSS';
//                 if "PRL-Period Transactions"."Transaction Code" = 'TOT-DED' then "PRL-Period Transactions"."Transaction Name" := 'DEDUCTIONS';
//                 if "PRL-Period Transactions"."Transaction Code" = 'NPAY' then "PRL-Period Transactions"."Transaction Name" := 'NET';
//             end;

//             trigger OnPreDataItem()
//             begin
//                 "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '%1..%2', EndPeriods, StartPeriods);
//                 Clear(seq);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(EndPeriods; EndPeriods)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Start Period';
//                     Editable = true;
//                     Enabled = true;
//                     TableRelation = "PRL-Payroll Periods"."Date Opened";
//                 }
//                 field(StartPeriods; StartPeriods)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'End Period';
//                     TableRelation = "PRL-Payroll Periods"."Date Closed";

//                     trigger OnValidate()
//                     begin
//                         if StartPeriods <> 0D then begin
//                             PayPeriods2.Reset;
//                             PayPeriods2.SetRange("Period Month", Date2DMY((CalcDate('<CM-2M+1D>', StartPeriods)), 2));
//                             PayPeriods2.SetRange("Period Year", Date2DMY((CalcDate('<CM-2M+1D>', StartPeriods)), 3));
//                             if PayPeriods2.Find('-') then begin
//                                 EndPeriods := PayPeriods2."Date Opened";
//                             end else begin
//                                 EndPeriods := 0D;
//                             end;
//                         end else begin
//                             PayPeriods2.Reset;
//                             PayPeriods2.SetRange(Closed, false);
//                             if PayPeriods2.Find('-') then begin
//                                 EndPeriods := PayPeriods2."Date Opened";
//                             end else begin
//                                 EndPeriods := 0D;
//                             end;
//                         end;

//                         //currp
//                     end;
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

//         if companyinfo.Get() then
//             companyinfo.CalcFields(companyinfo.Picture);
//         objPeriod.Reset;
//         objPeriod.SetRange(Closed, false);
//         if objPeriod.Find('-') then begin
//             StartPeriods := objPeriod."Date Opened";

//             if StartPeriods <> 0D then begin
//                 PayPeriods2.Reset;
//                 PayPeriods2.SetRange("Period Month", Date2DMY((CalcDate('<CM-2M+1D>', StartPeriods)), 2));
//                 PayPeriods2.SetRange("Period Year", Date2DMY((CalcDate('<CM-2M+1D>', StartPeriods)), 3));
//                 if PayPeriods2.Find('-') then begin
//                     EndPeriods := PayPeriods2."Date Opened";
//                 end else begin
//                     EndPeriods := 0D;
//                 end;
//             end else begin
//                 PayPeriods2.Reset;
//                 PayPeriods2.SetRange(Closed, false);
//                 if PayPeriods2.Find('-') then begin
//                     EndPeriods := PayPeriods2."Date Opened";
//                 end else begin
//                     EndPeriods := 0D;
//                 end;
//             end;
//         end;
//     end;

//     trigger OnPreReport()
//     begin
//         if StartPeriods = 0D then Error('Specify the start period!');
//         objPeriod.Reset;
//         if objPeriod.Get(StartPeriods) then PeriodName1 := objPeriod."Period Name";

//         objPeriod.Reset;
//         if objPeriod.Get(EndPeriods) then PeriodName2 := objPeriod."Period Name";
//     end;

//     var
//         PeriodTrans: Record "PRL-Period Transactions";
//         PeriodTrans1: Record "PRL-Period Transactions";
//         EmployeeName: Text[100];
//         objEmp: Record "HRM-Employee (D)";
//         objPeriod: Record "PRL-Payroll Periods";
//         SelectedPeriod: Date;
//         PeriodName1: Text[30];
//         PeriodName2: Text[30];
//         PeriodFilter: Text[30];
//         companyinfo: Record "Company Information";
//         Gross_and_Net_pay_scheduleCaptionLbl: Label 'Gross and Net pay schedule';
//         Basic_Pay_CaptionLbl: Label 'Basic Pay:';
//         Gross_Pay_CaptionLbl: Label 'Gross Pay:';
//         Net_Pay_CaptionLbl: Label 'Net Pay:';
//         User_Name_CaptionLbl: Label 'User Name:';
//         Print_Date_CaptionLbl: Label 'Print Date:';
//         Period_CaptionLbl: Label 'Period:';
//         Page_No_CaptionLbl: Label 'Page No:';
//         Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
//         Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
//         Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
//         Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
//         Totals_CaptionLbl: Label 'Totals:';
//         StartPeriods: Date;
//         EndPeriods: Date;
//         statAmount: Decimal;
//         seq: Integer;
//         PayPeriods2: Record "PRL-Payroll Periods";
//         PayPeriods1: Record "PRL-Payroll Periods";
// }

