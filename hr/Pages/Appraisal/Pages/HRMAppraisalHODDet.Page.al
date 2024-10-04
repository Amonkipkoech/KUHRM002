page 75049 "HRM-Appraisal HOD Det"
{
    PageType = List;
    SourceTable = 75019;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Target"; Rec."Appraisal Target")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Target Description"; Rec."Appraisal Target Description")
                {
                    ApplicationArea = All;
                }
                field(HOD; Rec.HOD)
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

