report 85536 "Validate Salaries"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "HRM-Employee (D)")
        {

            column(Steps; Steps)
            {

            }
            trigger OnAfterGetRecord()
            var
            begin
                Validate(Steps);
                Modify();
                //Message('All Salaries Updated Successfully!');
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