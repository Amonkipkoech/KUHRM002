report 50502 "Validate Allowance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/validateallowance.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; 61188)
        {
            RequestFilterFields = Status;
            column(No_; "No.")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Job_Title; "Job Title")
            {

            }
            column(Department_Code; "Department Code")
            {

            }
            column(Salary_Grade; "Salary Grade")
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                Validate("Salary Grade");
                Modify();
            end;



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