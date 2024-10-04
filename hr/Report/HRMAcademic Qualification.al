/// <summary>
/// Report Academic Qualification (ID 50103).
/// </summary>
report 50120 "HRMAcademic Qualification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMAcademic Qualification.rdl';
    Caption = 'Academic Qualification';

    dataset
    {
        dataitem(academicQualification; "HRM-Emp. Qualifications Final")
        {
            RequestFilterFields = "Employee No.", "Qualification Category";
            CalcFields = "Employee Name";
            column(Employee_No_; "Employee No.")
            {

            }
            column(Qualification_Category; "Qualification Category")
            {

            }
            column(Qualification; Qualification)
            {

            }
            column(Academic_Specialisation; "Academic Specialisation")
            {

            }
            column(Academic_Qualification_Code; "Academic Qualification Code")
            {

            }
            column(Academic_Specialisation_Code; "Academic Specialisation Code")
            {

            }

            column(Institution; "Institution")
            {

            }
            column(Year_Attended_From; "Year Attended From")
            {

            }
            column(Year_Attended_To; "Year Attended To")
            {

            }
            column(Employee_Name; "Employee Name")
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