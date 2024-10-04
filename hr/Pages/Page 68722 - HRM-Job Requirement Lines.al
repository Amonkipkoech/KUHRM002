page 68722 "HRM-Job Requirement Lines"
{
    CardPageID = "HRM-Job Requirements";
    DeleteAllowed = true;
    //InsertAllowed = true;
    //ModifyAllowed = false;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "HRM-Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Category"; Rec."Qualification Category")
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
                    MultiLine = true;
                }
                field("Grade Attained"; Rec."Grade Attained")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
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

