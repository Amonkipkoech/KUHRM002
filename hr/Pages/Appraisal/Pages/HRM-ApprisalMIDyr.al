page 85520 "Apprisal Mid Year"
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
                field(valueCode;Rec.valueCode)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field(Targets;Rec.Targets)
                {
                    Caption = 'Targets Changed Or Added';
                    ApplicationArea = All;
                }
                field("Perfomance Indicators";Rec."Perfomance Indicators")
                {
                    ApplicationArea = All;
                }
                field("Results Acheived";Rec."Results Acheived")
                {
                    ApplicationArea = All;
                }
                field("Performance Apprisal";Rec."Performance Apprisal")
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