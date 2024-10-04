page 68067 "PRL-Staff Dimensions"
{
    PageType = List;
    SourceTable = "PRL-Staff Dimensions";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dimension 0"; Rec."Dimension 0")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1"; Rec."Dimension 1")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    ApplicationArea = All;
                }
                field("Dimension 3"; Rec."Dimension 3")
                {
                    ApplicationArea = All;
                }
                field("Dimension 4"; Rec."Dimension 4")
                {
                    ApplicationArea = All;
                }
                field("Dimension 5"; Rec."Dimension 5")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
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

