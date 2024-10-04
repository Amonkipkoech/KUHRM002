page 75203 "HRM-InterviewSetup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "InterView Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee Requisition"; Rec."Employee Requisition")
                {
                    ApplicationArea = All;

                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
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