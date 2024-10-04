page 50006 "Discipline Cases Page Setup"
{
    PageType = List;
    SourceTable = "Indicpline Cases setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Code"; Rec."Case Code")
                {
                    ApplicationArea = All;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
                field("Possible Action"; Rec."Possible Action")
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

