page 68046 "HRM-Lookup Values Factbox"
{
    Caption = 'HR Lookup Values Factbox';
    PageType = CardPart;
    SourceTable = "HRM-Lookup Values";

    layout
    {
        area(content)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
            field("Code"; Rec.Code)
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Notice Period"; Rec."Notice Period")
            {
                ApplicationArea = All;
            }
            field(Closed; Rec.Closed)
            {
                ApplicationArea = All;
            }
            field("Contract Length"; Rec."Contract Length")
            {
                ApplicationArea = All;
            }
            field("Current Appraisal Period"; Rec."Current Appraisal Period")
            {
                ApplicationArea = All;
            }
            field("Disciplinary Case Rating"; Rec."Disciplinary Case Rating")
            {
                ApplicationArea = All;
            }
            field("Disciplinary Action"; Rec."Disciplinary Action")
            {
                ApplicationArea = All;
            }
            field(From; Rec.From)
            {
                ApplicationArea = All;
            }
            field("To"; Rec."To")
            {
                ApplicationArea = All;
            }
            field(Score; Rec.Score)
            {
                ApplicationArea = All;
            }
            field("Basic Salary"; Rec."Basic Salary")
            {
                ApplicationArea = All;
            }
            field("To be cleared by"; Rec."To be cleared by")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

