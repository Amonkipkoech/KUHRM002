page 50007 "Discipline Register"
{
    CardPageID = "Discipline Register Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Indispline Cases";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Indispline Code"; Rec."Indispline Code")
                {
                    ApplicationArea = All;
                }
                field("Indispline Description"; Rec."Indispline Description")
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                }
                field("Reported By"; Rec."Reported By")
                {
                    ApplicationArea = All;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PrintReport)
            {
                Caption = 'Print';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IndisplineCases.RESET;
                    IndisplineCases.SETRANGE("Year Code", Rec."Year Code");
                    IndisplineCases.SETRANGE("Indispline Id", Rec."Indispline Id");
                    IndisplineCases.SETRANGE("Indispline Code", Rec."Indispline Code");
                    IF IndisplineCases.FIND THEN
                        REPORT.RUN(68632, TRUE, FALSE, IndisplineCases);
                end;
            }
        }
    }

    var
        IndisplineCases: Record "Indispline Cases";
}

