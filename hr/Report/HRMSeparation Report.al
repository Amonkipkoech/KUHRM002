/// <summary>
/// Report Employee Separation (ID 50126).
/// </summary>
report 50126 "HRMEmployee Separation"
{
    DefaultLayout = RDLC;
    Caption = 'Employee Separation Report';
    RDLCLayout = './hr/Report/SSR/HRMemployeeSeparation.rdl';



    dataset
    {
        dataitem(employeeSeparation; 61215)
        {
            column(Exit_Clearance_No; "Exit Clearance No")
            {

            }
            column(Employee_No_; "Employee No.")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Appointment_Date; "Appointment Date")
            {

            }

            column(Date_Of_Leaving; "Date Of Leaving")
            {

            }
            column(Reason_For_Exit; "Reason For Exit")
            {

            }
            column(Employee_Clearance; "Employee Clearance")
            {

            }
            column(Final_Dues_Paid; "Final Dues Paid")
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