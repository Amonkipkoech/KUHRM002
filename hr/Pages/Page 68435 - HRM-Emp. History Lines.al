page 68435 "HRM-Emp. History Lines"
{
    PageType = ListPart;
    SourceTable = "HRM-Employment History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Payroll No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Academic Rank"; Rec."Academic Rank")
                {
                    ToolTip = 'Specifies the value of the Academic Rank field.';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field("Current or Previous"; Rec."Current or Previous")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current or Previous field.';
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field("Employment Category"; Rec."Employment Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Category field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.';
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Faculty field.';
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Faculty Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Job Group Code"; Rec."Job Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Group Code field.';
                }
                field("Job Cadre"; Rec."Job Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Cadre field.';
                }
                field("Supervisor Staff ID"; Rec."Supervisor Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Staff ID field.';
                }
                field("Supervisor Title"; Rec."Supervisor Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Title field.';
                }
                field("Date from"; Rec."Date from")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date from field.';
                }
                field("Date to"; Rec."Date to")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date to field.';
                }
                field("Date of Confirmation"; Rec."Date of Confirmation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Confirmation field.';
                }
                field("Terms of Service"; Rec."Terms of Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terms of Service field.';
                }
                field("Probation start date"; Rec."Probation start date")
                {
                    ApplicationArea = all;

                }
                field("Probation End date"; Rec."Probation End date")
                {
                    ApplicationArea = all;
                }
                field("Duration Of Contract(Months)"; Rec."Duration Of Contract(Months)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration Of Contract(Months) field.';
                }
                field("Date of Last Promotion"; Rec."Date of Last Promotion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Last Promotion field.';
                }
                field("Contract Expiry Date"; Rec."Contract Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Expiry Date field.';
                }
                field("Contract Expiry Notification"; Rec."Contract Expiry Notification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Expiry Notification Date field.';
                }






            }
        }
    }

    actions
    {
    }
}

