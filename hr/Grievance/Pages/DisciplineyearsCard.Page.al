page 50009 "Discipline years Card"
{
    PageType = Card;
    SourceTable = "Discpiline Years";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Year Code"; Rec."Year Code")
                {
                    ApplicationArea = All;
                }
                field("Year Description"; Rec."Year Description")
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

