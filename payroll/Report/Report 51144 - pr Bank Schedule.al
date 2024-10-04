report 51144 "pr Bank Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/pr Bank Schedule.rdl';
    PreviewMode = PrintLayout;
    Description = 'Bank Schedule';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No") ORDER(Ascending) WHERE("Transaction Code" = FILTER('NPAY'));
            RequestFilterFields = "Payroll Period";
            column(CompName; CompanyInformation.Name)
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
            column(TransAmount; "PRL-Period Transactions".Amount)
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
            column(Branch; HRMEmployeeD."Branch Bank")
            {
            }
            column(Bank; HRMEmployeeD."Main Bank")
            {
            }
            column(logo; CompanyInformation.Picture)
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
            CompanyInformation.CalcFields(Picture);
        end;
    end;

    var
        PeriodTRans: Record "PRL-Period Transactions";
        NPay: Decimal;
        TNpay: Decimal;
        GrantTotal: Decimal;
        PayrollPeriods: Record "PRL-Payroll Periods";
        CompanyInformation: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        HRMEmployeeD: Record "HRM-Employee (D)";
}

