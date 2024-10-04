page 68450 "HRM-Career Developement Plan"
{
    PageType = ListPart;
    SourceTable = 61333;

    layout
    {
        area(content)
        {
            repeater(rep001)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

