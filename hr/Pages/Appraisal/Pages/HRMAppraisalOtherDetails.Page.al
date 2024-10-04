page 68902 "HRM-Appraisal Other Details"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Goal Setting H";

    layout
    {
        area(content)
        {
            group("Mid Year Comments")
            {
                Caption = 'Mid Year Comments';
            }
            field("MY Comments"; Rec."MY Comments")
            {
                ApplicationArea = All;
            }
            field("MY Performance Rating"; Rec."MY Performance Rating")
            {
                ApplicationArea = All;
            }
            field("MY Appraiser Comments"; Rec."MY Appraiser Comments")
            {
                ApplicationArea = All;
            }
            field("MY Appraisee Comments"; Rec."MY Appraisee Comments")
            {
                ApplicationArea = All;
            }
            group("End Year Comments")
            {
                Caption = 'End Year Comments';
            }
            field("EY Appraiser Comments"; Rec."EY Appraiser Comments")
            {
                ApplicationArea = All;
            }
            field("EY Appraisee Comments"; Rec."EY Appraisee Comments")
            {
                ApplicationArea = All;
            }
            field("EY Performance Rating"; Rec."EY Performance Rating")
            {
                ApplicationArea = All;
            }
            field("Exceptional Issues"; Rec."Exceptional Issues")
            {
                ApplicationArea = All;
            }
            field("Career Aspirations"; Rec."Career Aspirations")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

