/// <summary>
/// Report Employee Details (ID 50104).
/// </summary>
report 50104 "Employee Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemployeeDetails.rdl';
    ApplicationArea = Basic, Suite;
    Caption = ' Employeee Details';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(employeeSummary; 61188)
        {
            column(PAYROLL_NO; "PAYROLL NO")
            {

            }
            column(First_Name; "First Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(Middle_Name; "Middle Name")
            {
            }
            column(Cellular_Phone_Number; "Cellular Phone Number")
            {

            }
            column(Gender; Gender)
            {

            }
            column(Department_Code; "Department Code")
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