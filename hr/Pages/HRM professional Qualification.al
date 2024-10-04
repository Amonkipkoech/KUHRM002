page 50014 "HRM-Professional Qualification"
{
    PageType = ListPart;
    // ApplicationArea = All;
    // UsageCategory = Listp
    SourceTable = "HRM-Professional Qualification";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Payroll No."; Rec."Payroll No.")
                {
                   
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payroll No. field.';
                    ApplicationArea = All;
                    
                }
                field("Membership No."; Rec."Membership No.")
                {
                    ToolTip = 'Specifies the value of the Membership No. field.';
                    ApplicationArea = All;
                }
                 field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the value of the Qualification Name field.';
                    ApplicationArea = All;
                }
                // field(Institution; Rec.Institution)
                // {
                //     ToolTip = 'Specifies the value of the Institution field.';
                //     ApplicationArea = All;
                // }
                // field("Institution Name"; Rec."Institution Name")
                // {
                //     ToolTip = 'Specifies the value of the Institution Name field.';
                //     ApplicationArea = All;
                // }
                field("Professional Qualification";Rec."Professional Qualification")
                {
                    ToolTip = 'Specifies Proffessional Body Attended';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Examination Body"; Rec."Examination Body")
                {
                    ToolTip = 'Specifies the value of the Examination Body field.';
                    ApplicationArea = All;
                }
                field("Year Attained"; Rec."Year Attained")
                {
                    ToolTip = 'Specifies the value of the Year Attained field.';
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                    ApplicationArea = All;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                    ApplicationArea = All;
                }
                               
                
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field.';
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
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}