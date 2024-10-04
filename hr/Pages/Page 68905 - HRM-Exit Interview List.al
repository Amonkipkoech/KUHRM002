page 68905 "HRM-Exit Interview List"
{
    Caption = 'Employee Separation List';
    CardPageID = "HRM-Emp. Exit Requisition";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Employee Exit Interviews";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                    ApplicationArea = All;
                }
                field("Reason For Exit"; Rec."Reason For Exit")
                {
                    ToolTip = 'Specifies the value of the Reason For Exit field.';
                    ApplicationArea = All;
                }
                field("Employee Clearance"; Rec."Employee Clearance")
                {
                    ToolTip = 'Specifies the value of the Employee Clearance field.';
                    ApplicationArea = All;
                }
                field("Final Dues Paid"; Rec."Final Dues Paid")
                {
                    ToolTip = 'Specifies the value of the Final Dues Paid field.';
                    ApplicationArea = All;
                }
                field("Date Final Dues Paid"; Rec."Date Final Dues Paid")
                {
                    ToolTip = 'Specifies the value of the Date Final Dues Paid field.';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Control1102755006; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

