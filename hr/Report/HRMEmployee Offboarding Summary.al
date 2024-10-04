/// <summary>
/// Report Employeee Offboarding Summary (ID 50102).
/// </summary>
report 50102 "Employeee Offboarding Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMoffboardingSummary.rdl';
    ApplicationArea = Basic, Suite;
    Caption = ' Employeee Offboarding Summary';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(empSummary; 61215)
        {
            column(Exit_Clearance_No; "Exit clearance No")
            {
            }
            column(Employee_No_; "Employee No.")
            {
            }
            column(Directorate_Code; "Directorate Code")
            {
            }
            column(Department_Code; "Department Code")
            {

            }
            column(Date_Of_Clearance; "Date Of Clearance")
            {
            }
            column(Nature_Of_Separation; "Nature Of Separation")
            {

            }
            column(Reason_For_Exit; "Reason For Exit")
            {

            }
            column(Date_Of_Leaving;
            "Date Of Leaving")
            {

            }
            column(Date_Final_Dues_Paid; "Date Final Dues Paid")
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