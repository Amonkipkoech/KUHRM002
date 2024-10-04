page 61836 "Tribes List"
{
    PageType = List;
    SourceTable = Tribes;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tribe Code"; Rec."Tribe Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

