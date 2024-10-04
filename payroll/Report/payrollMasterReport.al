report 85517 "PRL-Staff Master Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-StaffMaster.rdl';



    dataset
    {
        dataitem(salaryHead; "HRM-Employee (D)")
        {
            column(No_; "No.")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(Middle_Name; "Middle Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Job_Title; "Job Title")
            {

            }
            column(Salary_Category; "Salary Category")
            {

            }
            column(Salary_Grade; "Salary Grade")
            {

            }
            column(Job_Name;"Job Name")
            {

            }
            column(Campus;Campus)
            {

            }
            column(Main_Bank_Name;"Main Bank Name")
            {

            }
            column(Branch_Bank_Name;"Branch Bank Name")
            {
                
            }


            column(Department_Code; "Department Code")
            {

            }
            column(ID_Number; "ID Number")
            {

            }
            column(PIN_Number; "PIN Number")
            {
            }
            column(NHIF_No_; "NHIF No.")
            {

            }
            column(NSSF_No_; "NSSF No.")
            {

            }
            column(Date_Of_Join; "Date Of Join")
            {

            }
            column(Bank_Account_Number; "Bank Account Number")
            {

            }
            column(Bank_Name; "Bank Name")
            {

            }
            column(pic; compInfo.Picture)
            {

            }
            column(name; compInfo.Name)
            {

            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }
    }
    trigger OnInitReport()
    begin
        compInfo.Reset;
        if compInfo.Find('-') then begin
        end;
        if compInfo.Get() then
            compInfo.CalcFields(compInfo.Picture);
    end;


    var
        myInt: Integer;
        compInfo: Record "Company Information";
}