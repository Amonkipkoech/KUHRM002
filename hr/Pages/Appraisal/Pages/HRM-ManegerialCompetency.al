page 85519 "HRM Manegerial Competency"
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
                    Caption = 'ID';

                }
                field(competences; Rec."Managerial Competency")
                {
                    ApplicationArea = All;
                    Caption = 'Managerial Competency';

                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                }
                field("Acheivement Score"; Rec."Acheivement Score")
                {
                    ApplicationArea = All;
                }
                field("Final Score"; Rec."Final Score")
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