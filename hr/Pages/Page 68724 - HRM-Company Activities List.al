page 68724 "HRM-Company Activities List"
{
    CardPageID = "HRM-Company Activities Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Company Activities";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = all;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = all;
                }
                field("Employee Responsible"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field("Activity  Status>"; Rec."Activity Status")
                {
                    ApplicationArea = all;
                    Caption = 'Activity  Status';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HRM-Company Activities Factbox")
            {
                ApplicationArea = all;
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

