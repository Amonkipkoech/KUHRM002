/// <summary>
/// Report Job Group Table (ID 50127).
/// </summary>
report 50127 "HRMJob Group"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMjobGroup.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Job Group';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(jobGroup; 61790)
        {
            column(Employee_Category; "Employee Category")
            {

            }
            column(Salary_Grade_code; "Salary Grade code")
            {

            }
            column(Grade_Description; "Grade Description")
            {

            }
            column(Annual_Leave_Days; "Annual Leave Days")
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