page 69041 "HRM-Emp. Performance Target"
{
    PageType = ListPart;
    SourceTable = "HRM-Emp. Performance Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                }
                field("Appraisee Rating"; Rec."Appraisee Rating")
                {
                    ApplicationArea = All;
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
                {
                    ApplicationArea = All;
                }
                field("Agreed Rating"; Rec."Agreed Rating")
                {
                    ApplicationArea = All;
                }
                field("Maximum Rating"; Rec."Maximum Rating")
                {
                    ApplicationArea = All;
                }
                field("Total Targets"; Rec."Total Targets")
                {
                    ApplicationArea = All;
                }
                field("Total Rating"; Rec."Total Rating")
                {
                    ApplicationArea = All;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field(Barriers; Rec.Barriers)
                {
                    ApplicationArea = All;
                }
                field("Action Plan"; Rec."Action Plan")
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

