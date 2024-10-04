page 68980 "HRM-Emp. Values assesment"
{
    PageType = ListPart;
    SourceTable = 61632;

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
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Value factors"; Rec."Value factors")
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
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field("Agreed Rating New"; Rec."Agreed Rating New")
                {
                    ApplicationArea = All;
                }
                field("Total Targets"; Rec."Total Targets")
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

