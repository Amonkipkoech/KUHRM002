// report 51202 "PRL-Pension Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './payroll/Report/SSR/PRL-Pension Report.rdl';

//     dataset
//     {
//         dataitem("PRL-Transaction Codes"; "PRL-Transaction Codes")
//         {
//             DataItemTableView = WHERE("Special Transactions" = FILTER("Defined Contribution"));
//             column(CompName; CompanyInformation.Name)
//             {
//             }
//             column(CompAddress; CompanyInformation.Address)
//             {
//             }
//             column(CompPhone1; CompanyInformation."Phone No.")
//             {
//             }
//             column(CompPhone2; CompanyInformation."Phone No. 2")
//             {
//             }
//             column(CompEmail; CompanyInformation."E-Mail")
//             {
//             }
//             column(CompPage; CompanyInformation."Home Page")
//             {
//             }
//             /* column(CompPin; CompanyInformation."Company P.I.N")
//             {
//             } */
//             column(Pic; CompanyInformation.Picture)
//             {
//             }
//             column(CompRegNo; CompanyInformation."Registration No.")
//             {
//             }
//             dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
//             {
//                 column(pfNo; "HRM-Employee (D)"."No.")
//                 {
//                 }
//                 column(EmpPin; "HRM-Employee (D)"."PIN Number")
//                 {
//                 }
//                 column(EmpId; "HRM-Employee (D)"."ID Number")
//                 {
//                 }
//                 column(FName; "HRM-Employee (D)"."Last Name")
//                 {
//                 }
//                 column(MName; "HRM-Employee (D)"."Middle Name")
//                 {
//                 }
//                 column(LName; "HRM-Employee (D)"."First Name")
//                 {
//                 }
//                 column(EmployeeAmount; PRLPeriodTransactions.Amount)
//                 {
//                 }
//                 column(EmployerAmount; PRLEmployerDeductions.Amount)
//                 {
//                 }
//                 column(Tot; Gtoto)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     PRLEmployerDeductions.Reset;
//                     PRLEmployerDeductions.SetRange(PRLEmployerDeductions."Employee Code", "HRM-Employee (D)"."No.");
//                     PRLEmployerDeductions.SetRange(PRLEmployerDeductions."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
//                     PRLEmployerDeductions.SetRange(PRLEmployerDeductions."Payroll Period", datefilter);
//                     if PRLEmployerDeductions.Find('-') then begin
//                     end;

//                     PRLPeriodTransactions.Reset;
//                     PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
//                     PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
//                     PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
//                     if PRLPeriodTransactions.Find('-') then begin
//                     end else
//                         CurrReport.Skip;

//                     Gtoto := PRLPeriodTransactions.Amount + PRLEmployerDeductions.Amount;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if datefilter = 0D then Error('Specify the Period Date');
//                 Clear(Gtoto);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(DateFil; datefilter)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Filter';
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
//         PRLPayrollPeriods.Reset;
//         PRLPayrollPeriods.SetRange(PRLPayrollPeriods.Closed, false);
//         if PRLPayrollPeriods.Find('-') then begin
//             datefilter := PRLPayrollPeriods."Date Opened";
//         end;

//         if CompanyInformation.Get() then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//     end;

//     var
//         datefilter: Date;
//         PRLPayrollPeriods: Record "PRL-Payroll Periods";
//         CompanyInformation: Record "Company Information";
//         PRLPeriodTransactions: Record "PRL-Period Transactions";
//         PRLEmployerDeductions: Record "PRL-Employer Deductions";
//         Gtoto: Decimal;
// }

