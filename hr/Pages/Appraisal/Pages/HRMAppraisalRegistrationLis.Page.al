page 75052 "HRM-Appraisal Registration Lis"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 75007;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PF No."; Rec."PF No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Award; Rec.Award)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

