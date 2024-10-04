page 68725 "HRM-Proffessional Membership"
{
    PageType = List;
    SourceTable = "HRM-Proffessional Membership";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = all;
                }
                field("Name of Body"; Rec."Name of Body")
                {
                    ApplicationArea = all;
                }
                field("Date of Membership"; Rec."Date of Membership")
                {
                    ApplicationArea = all;
                }
                field("Membership Status"; Rec."Membership Status")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

