page 69175 "HRM-Institutions"
{
    PageType = Card;
    SourceTable = "HRM-Institutions";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = all;
                }
                field("Institution Name"; Rec."Institution Name")
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

