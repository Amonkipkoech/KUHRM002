page 68316 "HRM-SetUp List"
{
    CardPageID = "HRM-Setup";
    PageType = List;
    SourceTable = "HRM-Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = all;
                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Staff Clearance"; Rec."Staff Clearance")
                {
                    ToolTip = 'Specifies the value of the Staff Clearance field.';
                    ApplicationArea = All;
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = all;
                }
                field("Base Calendar"; Rec."Base Calendar")
                {
                    ApplicationArea = all;
                }
                field("Transport Req Nos"; Rec."Transport Req Nos")
                {
                    ApplicationArea = all;
                }
                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[FROM]"; Rec."Leave Posting Period[FROM]")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[TO]"; Rec."Leave Posting Period[TO]")
                {
                    ApplicationArea = all;
                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {
                    ApplicationArea = all;
                }
                field("Company Activities"; Rec."Company Activities")
                {
                    ApplicationArea = all;
                }
                field("Induction Nos"; Rec."Induction Nos")
                {
                    ApplicationArea = all;
                }
                field("Medical Claims Nos"; Rec."Medical Claims Nos")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Nos"; Rec."Medical Scheme Nos")
                {
                    ApplicationArea = all;
                }
                field("Days To Retirement"; Rec."Days To Retirement")
                {
                    ApplicationArea = all;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = all;
                }
                field("Back To Office Nos."; Rec."Back To Office Nos.")
                {
                    ApplicationArea = all;
                }
                field("TNA Nos."; Rec."TNA Nos.")
                {
                    ApplicationArea = all;
                }
                field("Pension Nos."; Rec."Pension Nos.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

