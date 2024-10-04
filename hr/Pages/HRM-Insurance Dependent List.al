page 50015 "HRM-Insurance Dependents List"
{
    Caption = 'Employee Dependents Insurance';
    PageType = Listpart;
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "HRM-Insurance Dependants";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("Payroll No."; Rec."Payroll No.")
                {
                    Editable =false;
                    ToolTip = 'Specifies the value of the Payroll No. field.';
                    ApplicationArea = All;
                }
                field("Dependent Names"; Rec."Dependent Names")
                {
                    ToolTip = 'Specifies the value of the Dependent Names field.';
                    ApplicationArea = All;
                }
                field("Dependent ID No/ Birth Cert No";Rec."Dependent ID No/ Birth Cert No")
                {
                    ToolTip = 'Specifies the value of the Dependent Insuarance Number.';
                    ApplicationArea = All;
                    Caption = 'Dependent Insurance No';
                }
                field("Dependent Insurance No."; Rec."Dependent Insurance No.")
                {
                    ToolTip = 'Specifies the value of the Dependent ID No/ Birth Cert No field.';
                    ApplicationArea = All;
                    
                    
                }
                field("Dependent DoB"; Rec."Dependent DoB")
                {
                    ToolTip = 'Specifies the value of the Dependent Date of Birth field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                }
                
                
                field("R/ship to Principal"; Rec."R/ship to Principal")
                {
                    ToolTip = 'Specifies the value of the Relationship to the Principal field.';
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
}