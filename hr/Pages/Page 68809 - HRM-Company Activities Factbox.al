page 68809 "HRM-Company Activities Factbox"
{
    PageType = CardPart;
    SourceTable = "HRM-Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                ShowCaption = false;
                field(Control1102755019; '')
                {
                    ApplicationArea = all;
                    CaptionClass = Text1;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
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
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Responsible';
                }
                field("Email Message"; Rec."Email Message")
                {
                    ApplicationArea = all;
                }
                field(Control1102755020; '')
                {
                    ApplicationArea = all;
                    CaptionClass = Text2;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = all;
                }
                field("Contribution Amount (If Any)"; Rec."Contribution Amount (If Any)")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = all;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No"; Rec."Bal. Account No")
                {
                    ApplicationArea = all;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
                field(Control1102755012; '')
                {
                    ApplicationArea = all;
                    CaptionClass = Text3;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field("Activity Status"; Rec."Activity Status")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: Label 'Activity Description';
        Text2: Label 'Activity Cost';
        Text3: Label 'Activity Status';
}

