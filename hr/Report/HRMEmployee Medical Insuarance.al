/// <summary>
/// Report Employee Medical Insuarance (ID 50122).
/// </summary>
report 50122 "HRMEmployee Medical Insuarance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemployeeMedicalInsurance.rdl';
    Caption = 'Employee Medical Insuarance';


    dataset
    {
        dataitem(employeeInsuarance; 61337)
        {
            RequestFilterFields = "Payroll No.";
            column(Payroll_No_; "Payroll No.")
            {

            }
            column(Principal_Insurance_Number; "Principal Insurance Number")
            {

            }
            column(Number_of_Dependents; "Number of Dependents")
            {

            }
            column(Insurance_Contract_Number; "Insurance Contract Number")
            {

            }
            column(Group_Life_Cover; "Group Life Cover")
            {

            }
            column(Group_Personal_Accident___WIBA; "Group Personal Accident & WIBA")
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