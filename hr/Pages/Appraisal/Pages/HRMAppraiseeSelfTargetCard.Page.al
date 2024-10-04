page 75056 "HRM-Appraisee Targets"
{
    DeleteAllowed = false;
    PageType = card;
    // Editable = false;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("PF. No."; Rec."PF. No.")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Target Code"; Rec."Appraisal Target Code")
                {
                    ApplicationArea = All;
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    Caption = 'Agreed Performance Targets/ Specific Tasks Assignment';
                    ApplicationArea = All;
                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                    ApplicationArea = All;
                }
                field("Mid Year Review (Remarks)"; Rec."Mid Year Review (Remarks)")
                {
                    ApplicationArea = All;
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    Editable = editability;
                    Enabled = editability;
                    ApplicationArea = All;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    Caption = 'Performance Appraisal Score';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("My Comments")
            {
                Caption = 'My Comments';
                Image = Comment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "HRM-Appraisal Appraisee Comm.";
                ApplicationArea = All;
            }
            action("Appraisee Training Requirements")
            {
                Caption = 'Appraisee Training Requirements';
                Image = Translation;
                Promoted = true;
                ApplicationArea = All;
                PromotedIsBig = true;
                RunObject = Page 75042;
                RunPageLink = "PF. No." = FIELD("PF. No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("PF. No.", '%1', UserSetup."Employee No.");
        Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
        IF Rec.Closed THEN editability := FALSE ELSE editability := TRUE
    end;

    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID) THEN;
        IF UserSetup."Employee No." = '' THEN ERROR(USERID + ' is not mapped to employee in the user setup');
        Rec.SETFILTER("PF. No.", '%1', UserSetup."Employee No.");
        HRMAppraisalYears.RESET;
        HRMAppraisalYears.SETRANGE(Closed, FALSE);
        IF HRMAppraisalYears.FIND('-') THEN
            Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
        /*
        HRMAppraisalPeriods.RESET;
        HRMAppraisalPeriods.SETFILTER(Closed,'%1',FALSE);
        IF HRMAppraisalPeriods.FIND('-') THEN
          SETFILTER("Appraisal Period Code",HRMAppraisalPeriods.Code);
          */
        CLEAR(editability);
        IF Rec.Closed THEN editability := FALSE ELSE editability := TRUE

    end;

    var
        UserSetup: Record 91;
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
}