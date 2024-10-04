page 50010 "Discipline Years List"
{
    CardPageID = "Discipline years Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Discpiline Years";

    layout
    {
        area(content)
        {
            repeater(Group)
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
        area(creation)
        {
            action(DiscName)
            {
                Caption = 'Indiscipline Cases';
                Image = AddToHome;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Discipline Register";
                RunPageLink = "Year Code" = FIELD("Year Code");
                ApplicationArea = All;
            }
            action(Dis_Years)
            {
                Caption = 'Discipline Years Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUN(88100, TRUE, FALSE);
                end;
            }
            action("Cases Register")
            {
                Caption = 'Discipline Cases Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IndisplineCases.RESET;
                    IndisplineCases.SETRANGE("Year Code", Rec."Year Code");
                    IF IndisplineCases.FINDFIRST THEN
                        REPORT.RUN(88101, TRUE, FALSE, IndisplineCases);
                end;
            }
        }
    }

    var
        IndisplineCases: Record "Indispline Cases";
}

