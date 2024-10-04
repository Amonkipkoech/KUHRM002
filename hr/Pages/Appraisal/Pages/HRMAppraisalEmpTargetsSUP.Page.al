page 75036 "HRM-Appraisal Emp Targets-SUP"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Reg. Transacton ID";Rec."Reg. Transacton ID")
                {
                    ApplicationArea = All;
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    Caption = 'Agreed Performance Targets';
                    ApplicationArea = All;
                }
                field("Weighting Score";Rec."Weighting Score")
                {
                    ApplicationArea = All;
                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                    ApplicationArea = All;
                    Caption = 'Performance Indicators';
                }
                field("Performance Percentage"; Rec."Performance Percentage")
                {
                    ApplicationArea = All;
                    
                    Caption = 'Results Acheived';
                }
                field("Perfomance Appraisal";Rec."Perfomance Appraisal")
                {
                    ApplicationArea = All;
                    
                    
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    ApplicationArea = All;
                    Visible = False;
                    
                }
                field("Mid Year Review (Remarks)"; Rec."Mid Year Review (Remarks)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                
                
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    trigger OnOpenPage()
    begin
        HRMAppraisalYears.RESET;
        HRMAppraisalYears.SETRANGE(Closed, FALSE);
        IF HRMAppraisalYears.FIND('-') THEN
            Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    var
        UserSetup: Record 91;
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
}

