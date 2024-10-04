report 70011 "PRL-Bank Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-Bank Schedule.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No") ORDER(Ascending) WHERE("Transaction Code" = FILTER('NPAY'));
            RequestFilterFields = "Payroll Period";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(pic; CompanyInformation.Picture)
            {

            }
            column(CompAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2")
            {
            }
            column(PhoneNo; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(PeriodName; PayrollPeriods."Period Name")
            {
            }
            column(TransAmount; format("PRL-Period Transactions".Amount))
            {
            }
            column(EmpNames; HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(EmpCode; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(AccNo; HRMEmployeeD."Bank Account Number")
            {
            }
            column(Branch; HRMEmployeeD."Main Bank Name")
            {
            }
            column(Bank; HRMEmployeeD."Branch Bank Name")
            {
            }
            column(bankcode; HRMEmployeeD."Main Bank")
            {

            }
            column(branchCode; HRMEmployeeD."Branch Bank")
            {

            }
            column(DetDate; DetDate)
            {

            }
            column(arreas; Format(arreas))
            {

            }

            trigger OnAfterGetRecord()
            begin
                if HRMEmployeeD.Get("PRL-Period Transactions"."Employee Code") then
                    if ((HRMEmployeeD."Employee Category" = 'CASUAL') or (HRMEmployeeD."Employee Category" = 'CASUALS'))
                        then
                        CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if "PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period") = '' then Error('Specify a period on the filters');
                PayrollPeriods.Reset;
                PayrollPeriods.SetFilter("Date Opened", "PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period"));
                if PayrollPeriods.Find('-') then begin
                end;
                
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then begin

        end;
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        PeriodFilter := objPeriod."Date Opened";



        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Create Salary") then begin
                AllowAccessSettings := usersetup."Create Salary";
                exit
            end;
        Error(Nopermission);


    end;


    trigger OnPreReport()
    begin
        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
            CLEAR(DetDate);
            DetDate := FORMAT(objPeriod."Period Name");
        END;
        prl.Reset();
        prl.SetRange("Transaction Code", 'NPAY');
        prl.SetRange("Payroll Period", SelectedPeriod);
        IF prl.Find('-') then begin
            repeat
                arreas := prl.Amount + arreas
            until prl.Next() = 0;
        end;
    end;

    var
        Bank_ScheduleCaptionLbl: Label 'Bank Schedule';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        KBA_Branch_CodeCaptionLbl: Label 'KBA Branch Code';
        Period_TotalCaptionLbl: Label 'Period Total';
        Full_NamesCaptionLbl: Label 'Full Names';
        Net_PayCaptionLbl: Label 'Net Pay';
        TotalCaptionLbl: Label 'Total';
        PeriodTRans: Record "PRL-Period Transactions";
        NPay: Decimal;
        TNpay: Decimal;
        GrantTotal: Decimal;
        PayrollPeriods: Record "PRL-Payroll Periods";
        CompanyInformation: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        HRMEmployeeD: Record "HRM-Employee (D)";
        SelectedPeriod: Date;
        PeriodFilter: Date;
        objPeriod: Record "PRL-Payroll Periods";
        PeriodName: Text[30];
        DetDate: Text[100];
        arreas: Decimal;
        prl: Record "PRL-Period Transactions";
        usersetup: Record "User Setup";
        Nopermission: Label 'You are not allowed to work on Salaries';
        AllowAccessSettings: boolean;
}

