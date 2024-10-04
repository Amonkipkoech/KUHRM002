page 61844 "PRL Approval Active List"
{
    CardPageID = "PRL-Header Salary Card";
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      Where(Status = filter(Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field("No."; Rec."No.")
                {
                    Applicationarea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    Applicationarea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Applicationarea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Applicationarea = all;
                }
                field(Title; Rec.Title)
                {
                    Applicationarea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Applicationarea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Applicationarea = all;
                }

                field(Gender; Rec.Gender)
                {
                    Applicationarea = all;
                }

                field(Status; Rec.Status)
                {
                    Applicationarea = all;
                }

                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    Applicationarea = all;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Applicationarea = all;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    Applicationarea = all;
                }


            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(View2PagePayslip)
            {
                ApplicationArea = all;
                Caption = 'Payslip (Horizontal)';
                Image = Payment;



                Visible = false;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    if SalCard.Find('-') then
                        REPORT.Run(51745, true, false, SalCard);
                end;
            }
            action(ViewhorPayslip)
            {
                ApplicationArea = all;
                Caption = 'Payslip';
                Image = PrintReport;




                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    objEmp.Reset;
                    objEmp.SetRange(objEmp."No.", Rec."No.");
                    if objEmp.Find('-') then
                        REPORT.Run(64310, true, false, objEmp);
                end;
            }
            action(View3PagePayslip)
            {
                ApplicationArea = all;
                Caption = 'View3 Pages Payslip';
                Image = PaymentHistory;



                Visible = false;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    if SalCard.Find('-') then
                        REPORT.Run(51143, true, false, SalCard);
                end;
            }
            action("vew payslip")
            {
                ApplicationArea = all;
                Caption = 'vew payslip';
                Image = "Report";

                //todo  RunObject = Report "Individual Payslips mst";
                Visible = false;
            }
            action("Master Payroll Summary")
            {
                ApplicationArea = all;
                Caption = 'Master Payroll Summary';
                Image = "Report";


                RunObject = Report "Payroll Summary 3";
            }
            action("Deductions Summary 2")
            {
                ApplicationArea = all;
                Caption = 'Deductions Summary 2';
                Image = "Report";

                Visible = false;
                RunObject = Report "PRL-Deductions Summary 2 a";
            }
            action("Payroll summary")
            {
                ApplicationArea = all;
                Caption = 'Payroll summary';
                Image = Report;
                RunObject = Report "Payroll Summary 2";
                Visible = false;
            }
            action("Deductions Summary")
            {
                ApplicationArea = all;
                Caption = 'Deductions Summary';
                Image = Report;
                RunObject = Report "PRL-Deductions Summary 2 a";
            }
            action("Earnings Summary")
            {
                ApplicationArea = all;
                Caption = 'Earnings Summary';
                Image = DepositSlip;
                RunObject = Report "PRL-Earnings Summary 5";
            }

            action("Third Rule")
            {
                ApplicationArea = all;
                Caption = 'Third Rule';
                Image = AddWatch;
                RunObject = Report "A third Rule Report";
            }

            action("bank Schedule")
            {
                ApplicationArea = all;
                Caption = 'bank Schedule';
                Image = "Report";

                RunObject = Report "PRL-Bank Schedule";
            }

            action("P.10")
            {
                ApplicationArea = all;
                Caption = 'P.10';
                Image = "Report";

                //RunObject = Report "P.10 A mst";
            }
            action("P9 Report")
            {
                ApplicationArea = all;
                Caption = 'P9 Report';
                Image = Report2;


                RunObject = Report "P9 Report (Final)";
            }
            action("Paye Scheule")
            {
                ApplicationArea = all;
                Caption = 'Paye Scheule';
                Image = "Report";

                RunObject = Report "prPaye Schedule mst";

            }

            action("NSSF Schedule")
            {
                ApplicationArea = all;
                Caption = 'NSSF Schedule';
                Image = "Report";

                RunObject = Report "prNSSF mst";
            }
        }

    }

    trigger OnOpenPage()
    begin
        IF (DepCode <> '') THEN
            Rec.SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
            Rec.SETFILTER(Office, ' = %1', OfficeCode);

    end;

    var
        ProcessPayroll: Codeunit prPayrollProcessing;
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];
        objEmp: Record "HRM-Employee (D)";
        SalCard: Record "PRL-Salary Card";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        //ProcessPayroll: Codeunit prPayrollProcessing;
        HrEmployee: Record "HRM-Employee (D)";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PRL-Period Transactions";
        prEmployerDeductions: Record "PRL-Employer Deductions";
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";
        HREmp: Record "HRM-Employee (D)";
        j: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        salaryCard: Record "PRL-Salary Card";
        dateofJoining: Date;
        dateofLeaving: Date;
        GetsPAYERelief: Boolean;
        DOJ: Date;
        SalCard2: Record "PRL-Salary Card";
        EDformat: Label 'Prepare your csv doucment in this format \column 1 > Employee code(BFL001) \column 2 > Transaction Code(D2001) \ column 3 > Amount(2500)  \ column 4 > Balance(0) \column 5 > Payroll Period(01/11/2021) \column 6 > Payroll month(11) \column 7 > Payroll year(2021) \';


    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}