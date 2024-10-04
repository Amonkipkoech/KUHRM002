report 50501 "Validate Title"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/validatetitle.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem(empHist; "HRM-Employment History")
        {
            RequestFilterFields = Campus;
            // column(No_;"No.")
            // {

            // }
            // column(First_Name;"First Name")
            // {

            // }
            // column(Job_Title;"Job Title")
            // {

            // }
            // column(Department_Code;"Department Code")
            // {

            // }
            trigger OnAfterGetRecord()
            var
            begin
                Validate("Employee No.");
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