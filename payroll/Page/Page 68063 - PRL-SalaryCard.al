page 68063 "PRL-SalaryCard"
{
    PageType = ListPart;
    SourceTable = "PRL-Salary Card";
    SourceTableView = WHERE(Closed = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Control1000000001)
            {
                ShowCaption = false;
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = all;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                    // ApplicationArea = all;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    // ApplicationArea = all;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = all;
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = all;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = all;
                }
                field("Pays Pension"; Rec."Pays Pension")
                {
                    ApplicationArea = all;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = all;
                }
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = all;
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = all;
                }
                field("Suspension Reasons"; Rec."Suspension Reasons")
                {
                    ApplicationArea = all;
                }
                field("Cumm BasicPay"; Rec."Cumm BasicPay")
                {
                    ApplicationArea = all;
                }
                field("Cumm GrossPay"; Rec."Cumm GrossPay")
                {
                    ApplicationArea = all;
                }
                field("Cumm NetPay"; Rec."Cumm NetPay")
                {
                    ApplicationArea = all;
                }
                field("Cumm Allowances"; Rec."Cumm Allowances")
                {
                    ApplicationArea = all;
                }
                field("Cumm Deductions"; Rec."Cumm Deductions")
                {
                    ApplicationArea = all;
                }
                field("Period Filter"; Rec."Period Filter")
                {
                    ApplicationArea = all;
                }
                field("Cumm PAYE"; Rec."Cumm PAYE")
                {
                    ApplicationArea = all;
                }
                field("Cumm NSSF"; Rec."Cumm NSSF")
                {
                    ApplicationArea = all;
                }
                field("Cumm Pension"; Rec."Cumm Pension")
                {
                    ApplicationArea = all;
                }
                field("Cumm HELB"; Rec."Cumm HELB")
                {
                    ApplicationArea = all;
                }
                field("Cumm NHIF"; Rec."Cumm NHIF")
                {
                    ApplicationArea = all;
                }
                field("Cumm Employer Pension"; Rec."Cumm Employer Pension")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        //  Mail: Codeunit Mail;
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
        ProcessPayroll: Codeunit prPayrollProcessing;
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
}

