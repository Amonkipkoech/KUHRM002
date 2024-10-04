page 69069 "HRM-Stage Requirement Lines"
{
    PageType = List;
    SourceTable = "HRM-Stage Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Grade Attained"; Rec."Grade Attained")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    ApplicationArea = All;
                }
                field("Total (Stage)Desired Score"; Rec."Total (Stage)Desired Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

