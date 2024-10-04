page 75054 "Human Resource Setup"
{
    SourceTable = "HRM-Human Resources Setup.";
    PageType = List;
    Caption = 'Human Resource SetUps';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Applicants Nos."; Rec."Applicants Nos.")
                {
                    ToolTip = 'Specifies the value of the Applicants Nos. field.';
                    ApplicationArea = All;
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Cases Nos. field.';
                    ApplicationArea = All;
                }
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ToolTip = 'Specifies the value of the Employee Nos. field.';
                    ApplicationArea = All;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ToolTip = 'Specifies the value of the Leave Application Nos. field.';
                    ApplicationArea = All;
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                    ApplicationArea = All;
                }
                field("Recruitment Needs Nos."; Rec."Recruitment Needs Nos.")
                {
                    ToolTip = 'Specifies the value of the Recruitment Needs Nos. field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}