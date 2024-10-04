page 69101 "HRM-Unaffected Sal. Increament"
{
    Editable = false;
    PageType = List;
    SourceTable = "HRM-UnAffected Sal. Increament";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Increament Month"; Rec."Increament Month")
                {
                    ApplicationArea = all;
                }
                field("Increament Year"; Rec."Increament Year")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = all;
                }
                field("Employee Grade"; Rec."Employee Grade")
                {
                    ApplicationArea = all;
                }
                field(Reason; Rec.Reason)
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

