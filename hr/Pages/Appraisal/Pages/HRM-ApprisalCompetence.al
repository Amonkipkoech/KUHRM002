page 85518 "Core Competences"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM Apprisal Values";

    layout
    {
        area(Content)
        {
            repeater(rep)
            {
                field(valueCode; Rec.valueCode)
                {
                    ApplicationArea = All;
                    Caption = 'Value Code';

                }
                field(competences;Rec.competences)
                {
                    ApplicationArea = All;

                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                }
                field("Acheivement Score";Rec."Acheivement Score")
                {
                    ApplicationArea = All;
                }
                field("Final Score";Rec."Final Score")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}