page 68071 "PRL-TimeSheets"
{
    PageType = Card;
    SourceTable = "PRL-TimeSheets";

    layout
    {
        area(content)
        {
            field("Schedule Code"; Rec."Schedule Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Primary File Path"; Rec."Primary File Path")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Secondary File Path"; Rec."Secondary File Path")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Delete After Import"; Rec."Delete After Import")
            {
                ApplicationArea = All;
            }
            field(Control1102755014; '')
            {
                CaptionClass = Text19036653;
                ShowCaption = false;
                ApplicationArea = All;
            }
            field(Control1102755000; '')
            {
                CaptionClass = Text19075848;
                ShowCaption = false;
                ApplicationArea = All;
            }
            field(Control1102755001; '')
            {
                CaptionClass = Text19037672;
                ShowCaption = false;
                ApplicationArea = All;
            }
            field(Control1102755003; '')
            {
                CaptionClass = Text19057798;
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        objOcx: Codeunit prPayrollProcessing;
        Text19057798: Label 'e.g   C:\monte\Timesheets\main folder\';
        Text19037672: Label 'e.g   E:\monte\Back Up\Timesheets\';
        Text19075848: Label 'NB:  if ticked, system deletes the imported files from the "Primary Directory"';
        Text19036653: Label 'To view imported details, go to: "Salary Card" > "Other Info" > "Cost Centers"';
}

