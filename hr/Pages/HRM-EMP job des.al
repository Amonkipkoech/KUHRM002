page 85608 "Employee Job Description"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Responsibility Contact';
    PageType = List;
    SourceTable = "HRM Responsiblities Contract";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
               
                
                // field("Payroll Number"; Rec."Payroll Number")
                // {
                    
                //     ToolTip = 'Specifies the value of the Payroll Number field.';
                //     ApplicationArea = All;
                    
                // }
                //  field("Employee Name"; Rec."Employee Name")
                // {
                //     ToolTip = 'Specifies the value of the Employee Name field.';
                //     ApplicationArea = All;
                // }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Primary Job Title field.';
                    ApplicationArea = All;
                }
                // field("Responsibility Code"; Rec."Responsibility Code")
                // {
                //     ToolTip = 'Specifies the value of the Responsibility Code field.';
                //     ApplicationArea = All;
                //     Visible =  false;
                // }
                field("Responsibility Description";Rec."Responsibility Description")
                {
                    ToolTip = 'Specifies the value of the Responsibility Description field.';
                    ApplicationArea = All;
                }
                // field("Faculty Code"; Rec."Faculty Code")
                // {
                //     ToolTip = 'Specifies the value of the Faculty Code field.';
                //     ApplicationArea = All;
                //     Caption = 'Faculty/Centre/Institute/School/Directorate';

                // }
                // field("Department Code"; Rec."Department Code")
                // {
                //     ToolTip = 'Specifies the value of the Department Code field.';
                //     ApplicationArea = All;
                // }
                // field(Department; Rec.Department)
                // {
                //     ToolTip = 'Specifies the value of the Department field.';
                //     ApplicationArea = All;
                // }
                // field("Campus Code"; Rec."Campus Code")
                // {
                //     ToolTip = 'Specifies the value of the Campus Code field.';
                //     ApplicationArea = All;
                // }
                // field("Duration"; Rec."Duration")
                // {
                //     ToolTip = 'Specifies the value of the Duration field.';
                //     ApplicationArea = All;
                // }
               
                // field("From Date"; Rec."From Date")
                // {
                //     ToolTip = 'Specifies the value of the From Date field.';
                //     ApplicationArea = All;
                // }
                // field("To Date"; Rec."To Date")
                // {
                //     ToolTip = 'Specifies the value of the To Date field.';
                //     ApplicationArea = All;
                // }
                // field("Expiry Notificaion date"; Rec."Expiry Notificaion date")
                // {
                //     ToolTip = 'Specifies the value of the Expiry Notificaion date field.';
                //     ApplicationArea = All;
                // }
                
                
                
                
            }
        }
    }

    actions
    {
    }
}

