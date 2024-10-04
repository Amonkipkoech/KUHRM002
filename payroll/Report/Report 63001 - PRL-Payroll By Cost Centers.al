report 63001 "PRL-Payroll By Cost Centers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-Payroll By Cost Centers.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code") ORDER(Ascending) WHERE("Group Text" = FILTER('DEDUCTIONS' | 'STATUTORIES' | 'NET PAY' | 'DEFCON'));
            column(EmpCodes; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(PerMonth; "PRL-Period Transactions"."Period Month")
            {
            }
            column(PerYear; "PRL-Period Transactions"."Period Year")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(PayAmount; "PRL-Period Transactions".Amount)
            {
            }
            column(GroupOrder; "PRL-Period Transactions"."Group Order")
            {
            }
            column(SubGroupOrder; "PRL-Period Transactions"."Sub Group Order")
            {
            }
            column(PayPeriod; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(DeptCode; "PRL-Period Transactions"."Department Code")
            {
            }
            column(pyrlCode; "PRL-Period Transactions"."Payroll Code")
            {
            }
            column(DeptName; DimensionValue.Name)
            {
            }
            column(payper; payper)
            {
            }
            column(compname; CompanyInformation.Name)
            {
            }
            column(compAddress; CompanyInformation.Address)
            {
            }
            column(CompAddress2; CompanyInformation."Address 2")
            {
            }
            column(Phoneno; CompanyInformation."Phone No.")
            {
            }
            column(PhoneNo2; CompanyInformation."Phone No. 2")
            {
            }
            column(pic; CompanyInformation.Picture)
            {
            }
            column(email; CompanyInformation."E-Mail")
            {
            }
            column(homep; CompanyInformation."Home Page")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "PRL-Period Transactions"."Payroll Period" <> payper then CurrReport.Skip;
                DimensionValue.Reset;
                DimensionValue.SetRange("Dimension Code", 'COST CENTERS');
                DimensionValue.SetRange(Code, "PRL-Period Transactions"."Department Code");
                if DimensionValue.Find('-') then begin
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(payper; payper)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
            }
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
        periods.Reset;
        periods.SetRange(periods.Closed, false);
        if periods.Find('-') then begin
            payper := periods."Date Opened";
        end;

        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(Picture);
        end;
    end;

    trigger OnPreReport()
    begin

        if payper = 0D then Error('Specify the Payroll Period');

        //"PRL-Period Transactions".RESET;
        //"PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period",'=%1',payper);
        //IF "PRL-Period Transactions".FIND('-') THEN BEGIN
        // END;
    end;

    var
        DimensionValue: Record "Dimension Value";
        payper: Date;
        periods: Record "PRL-Payroll Periods";
        CompanyInformation: Record "Company Information";
}

