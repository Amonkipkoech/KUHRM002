page 68909 "HRM-Job Requirement Lines(B)"
{
    Caption = 'HR Job Requirements';
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HRM-Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = all;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = all;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    ApplicationArea = all;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

