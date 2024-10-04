/// <summary>
/// Report Employee Dependents (ID 50123).
/// </summary>
report 50123 "HRMEmployee Dependents"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemployeeDependents.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Employee Dependents';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    
    

    dataset
    {
        dataitem(employeeDependents; 50007)
        {
            column(Payroll_No_; "Payroll No.")
            {

            }
            column(Dependent_Names; "Dependent Names")
            {

            }
            column(Dependent_Insurance_No_; "Dependent Insurance No.")
            {

            }
            column(Dependent_DoB; "Dependent DoB")
            {

            }
            column(Gender; Gender)
            {

            }
            column(R_ship_to_Principal; "R/ship to Principal")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {

            }
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
    trigger OnInitReport()
    begin
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}