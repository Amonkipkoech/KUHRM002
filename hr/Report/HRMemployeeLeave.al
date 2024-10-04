report 75204 "Employees On Leave"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemployeesLeave.rdl';
    dataset
    {
        dataitem(leave; "HRM-Leave Requisition")
        {
            RequestFilterFields = "Leave Type", Status;
            column(No_; "No.")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Department_Code; "Department Code")
            {

            }
            column(Starting_Date; "Starting Date")
            {

            }
            column(End_Date; "End Date")
            {

            }
            column(Return_Date; "Return Date")
            {

            }
            column(Purpose; Purpose)
            {

            }
            column(Leave_Type; "Leave Type")
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

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

   

    var
        myInt: Integer;
}