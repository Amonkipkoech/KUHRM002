page 68165 "PRL-View Filter Payrol"
{
    PageType = List;
    SourceTable = "PRL-Filter View Payroll";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("View Payroll"; Rec."View Payroll")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

