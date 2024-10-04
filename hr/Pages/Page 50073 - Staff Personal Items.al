page 50073 "Staff Personal Items"
{
    PageType = ListPart;
    SourceTable = "Staff Personal Items";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field(Cleared; Rec.Cleared)
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

