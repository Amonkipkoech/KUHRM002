page 50016 "HRM-Employee Insurance"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "GEN-Medical Scheme";
    Caption = 'HRM-Employee Insurance Statistics';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Payroll No."; Rec."Payroll No.")
                {
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Payroll No. field.';
                    ApplicationArea = All;
                }
                field("Principal Insurance Number"; Rec."Principal Insurance Number")
                {
                    ToolTip = 'Specifies the value of the Principal Insurance Number field.';
                    ApplicationArea = All;
                }
                field("Number of Dependents"; Rec."Number of Dependents")
                {
                    ToolTip = 'Specifies the value of the Number of Dependents field.';
                    ApplicationArea = All;
                }
                field("Insurance Contract Number"; Rec."Insurance Contract Number")
                {
                    ToolTip = 'Specifies the value of the Insurance Contract Number field.';
                    ApplicationArea = All;
                }
                field("Group Life Cover"; Rec."Group Life Cover")
                {
                    ToolTip = 'Specifies the value of the Group Life Cover field.';
                    ApplicationArea = All;
                }
                               
                field("Group Personal Accident & WIBA"; Rec."Group Personal Accident & WIBA")
                {
                    ToolTip = 'Specifies the value of the Group Personal Accident & WIBA field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
            }
        }
    }
    
    var
        myInt: Integer;
}