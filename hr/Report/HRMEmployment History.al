/// <summary>
/// Report Employment History (ID 50101).
/// </summary>
report 50101 "HRMEmployment History"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemploymentHistory.rdl';
    Caption = 'Employment History';

    dataset
    {
        dataitem(emphistory; "HRM-Employment History")
        {
            RequestFilterFields = "Employee No.", "Current or Previous", Division, "Employment Category";
            column(Employee_No_; "Employee No.")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }


            column(Campus; Campus)
            {

            }
            column(Job_Title; "Job Title")
            {

            }
            column(Academic_Rank; "Academic Rank")
            {

            }
            column(Employment_Category; "Employment Category")
            {

            }
            column(Division; Division)
            {

            }
            column(Faculty_Name; "Faculty Name")
            {

            }
            column(Department_Name; "Department Name")
            {

            }
            column(Duration_Of_Contract_Months_; format("Duration Of Contract(Months)"))
            {

            }
            column(Contract_Expiry_Date; format("Contract Expiry Date"))
            {

            }
            
            column(Terms_of_Service; "Terms of Service")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(Current_or_Previous; "Current or Previous")
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