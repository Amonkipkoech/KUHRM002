page 68098 "HRM-Appraisal Header"
{
    PageType = Document;
    SourceTable = 61074;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee First Name"; Rec."Employee First Name")
                {
                    ApplicationArea = All;
                }
                field("Employee Last Name"; Rec."Employee Last Name")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = All;
                }
                field("Next Appraisal Date"; Rec."Next Appraisal Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

