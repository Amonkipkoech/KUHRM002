report 85531 "PayslipTest"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './payroll/Report/SSR/paySlipTest.rdl';
    RDLCLayout = './payroll/Report/SSR/paySlipTest.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Period Filter";
            column(CompName; compInfo.Name)
            {
            }
            column(pic; compInfo.Picture)
            {

            }
            column(EmpNo; "HRM-Employee (D)"."No.")
            {
            }
            column(Names; "HRM-Employee (D)"."Last Name" + ' ' + "HRM-Employee (D)"."Middle Name" + ' ' + "HRM-Employee (D)"."First Name")
            {
            }

            column(DOJ; "HRM-Employee (D)"."Date Of Join")
            {
            }
            column(PinNo; "HRM-Employee (D)"."PIN Number")
            {
            }
            column(PeriodFilter; Periods)
            {
            }
            column(LegnthOfService; LegnthOfService)
            {
            }
            column(PayslipMessage; PRLPayrollPeriods."Payslip Message")
            {
            }
            column(Grade_Level; "Grade Level")
            {

            }
            column(Salary_Grade; "Salary Grade")
            {

            }
            column(Job_Name; "Job Name")
            {

            }
            column(Department_Name; "Department Name")
            {

            }
            column(Campus; Campus)
            {

            }
            column(ClosureSectionRemark; ' ')
            {
            }

            column(AccNo; "HRM-Employee (D)"."Bank Account Number")
            {
            }
            column(bankBranch; bankBranch)
            {

            }
            column(bankName; bankName)
            {

            }

            dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(GroupText; "PRL-Period Transactions"."Group Text")
                {
                }
                column(TransCode; "PRL-Period Transactions"."Transaction Code")
                {
                }
                column(TransName; "PRL-Period Transactions"."Transaction Name")
                {
                }
                column(TransAmount; "PRL-Period Transactions".Amount)
                {
                }
                column(TransBalance; "PRL-Period Transactions".Balance)
                {
                }
                column(GO; "PRL-Period Transactions"."Group Order")
                {
                }
                column(PerName; PerName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");

                    if "PRL-Period Transactions"."Group Text" = 'GROSS PAY' then CurrReport.Skip;
                    if "PRL-Period Transactions"."Group Text" = 'STATUTORIES' then "PRL-Period Transactions"."Group Text" := 'DEDUCTIONS';
                end;

                trigger OnPreDataItem()
                begin
                    PRLPayrollPeriods.Reset;
                    PRLPayrollPeriods.SetRange("Date Opened", Periods);
                    if PRLPayrollPeriods.Find('-') then begin
                        PerName := PRLPayrollPeriods."Period Name";
                    end;
                    "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '=%1', Periods);
                    //periodFilter := "HRM-Employee (D)".GetFilter("HRM-Employee (D)"."Period Filter");
                    // Periods := "HRM-Employee (D)".GetRangeMin("HRM-Employee (D)"."Period Filter");
                    // "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '=%1', Periods);
                    //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");
                end;
            }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                Periods := "HRM-Employee (D)".GetRangeMin("HRM-Employee (D)"."Period Filter2");
                Clear(LegnthOfService);
                if "HRM-Employee (D)"."Date Of Join" <> 0D then
                    LegnthOfService := HRDates.DetermineAge_Years("HRM-Employee (D)"."Date Of Join", "HRM-Employee (D)"."Date Filter");

                PRLBankStructure.Reset;
                PRLBankStructure.SetRange(PRLBankStructure."Bank Code", "HRM-Employee (D)"."Main Bank");
                if PRLBankStructure.Find('-') then begin
                end;

                if "HRM-Employee (D)"."Bank Account Number" = '' then "HRM-Employee (D)"."Bank Account Number" := 'No Banking Data';
                hrEmp.Reset();
                hrEmp.SetRange("No.", "HRM-Employee (D)"."No.");
                if hrEmp.Find('-') then begin
                    bankBranch := "HRM-Employee (D)"."Branch Bank Name";
                    bankName := "HRM-Employee (D)"."Main Bank Name";
                end;
            end;

        }
    }

    requestpage
    {

        layout
        {
            // area(content)
            // {
            //     field(PerNamePeriods; "HRM-Employee (D)"."Period Filter")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Period Filter';
            //         TableRelation = "PRL-Payroll Periods"."Date Opened";
            //     }
            // }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        compInfo.Reset;
        if compInfo.Find('-') then begin
        end;
        if compInfo.Get() then
            compInfo.CalcFields(compInfo.Picture);

        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(Closed, false);
        PRLPayrollPeriods.SetFilter("Payroll Code", 'PAYROLL');
        if PRLPayrollPeriods.Find('-') then Periods := PRLPayrollPeriods."Date Opened";
    end;

    trigger OnPreReport()
    begin
        //report bug fixes
        // if (Periods = 0D) and ("HRM-Employee (D)"."Period Filter" <> 0D) then
        //     Periods := "HRM-Employee (D)"."Period Filter"
        // else
        //     Periods := Periods;
        //
        //if Periods = 0D then Error('Specify the date filter!');


    end;

    var
        HRDates: Codeunit "HR Dates";
        PerName: Code[50];
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        Periods: Date;
        LegnthOfService: Code[50];
        compInfo: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        periodFilter: Text[50];
        hrEmp: Record "HRM-Employee (D)";
        bankBranch: Text[100];
        bankName: text[100];
}

