page 68910 "HRM-Job Responsiblities (B)"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Responsibility Contact';
    Editable = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HRM Responsiblities Contract";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {

                field("Payroll No."; Rec."Payroll No.")
                {
                    ToolTip = 'Specifies the value of the Payroll No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    //Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Primary Job Title field.';
                    ApplicationArea = All;
                }
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ToolTip = 'Specifies the value of the Responsibility Code field.';
                    ApplicationArea = All;

                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ToolTip = 'Specifies the value of the Responsibility Description field.';
                    ApplicationArea = All;
                    Caption = 'Responsibility';
                }
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                    ApplicationArea = All;


                }
                field(Faculty; Rec.Faculty)
                {
                    ToolTip = 'Specifies the value of the Faculty Name field.';
                    ApplicationArea = All;
                    Caption = 'Faculty/Centre/Institute/School/Directorate';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ToolTip = 'Specifies the value of the Campus Code field.';
                    ApplicationArea = All;
                }
                // field("Duration"; Rec."Duration")
                // {
                //     ToolTip = 'Specifies the value of the Duration field.';
                //     ApplicationArea = All;
                // }

                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                    ApplicationArea = All;
                }
                field("Expiry Notificaion date"; Rec."Expiry Notificaion date")
                {
                    ToolTip = 'Specifies the value of the Expiry Notificaion date field.';
                    ApplicationArea = All;
                }




            }
        }
    }

    actions
    {
    }
}

