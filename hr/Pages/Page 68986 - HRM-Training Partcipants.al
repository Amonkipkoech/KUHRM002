page 68986 "HRM-Training Partcipants"
{
    PageType = List;
    SourceTable = "HRM-Training Participants";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Code"; Rec."Training Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll No';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = all;
                }
                field("Department Code";Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field(Department;Rec.Department)
                {
                    ApplicationArea = all;
                }
                field("Training Description";Rec."Training Description")
                {

                }
                // field("Employee name"; Rec."Employee name")
                // {
                //     ApplicationArea = all;
                // }
                 field("Scholarship Type"; Rec."Scholarship Type")
                {
                    ToolTip = 'Specifies the value of the Scholarship Type field.';
                    ApplicationArea = All;
                }
                field("Scholarship Period"; Rec."Scholarship Period")
                {
                    ToolTip = 'Specifies the value of the Scholarship Period field.';
                    ApplicationArea = All;
                }
                field("Training Institution";Rec."Training Institution")
                {
                    ApplicationArea =  all;
                }
                field("Training Cost";Rec."Training Cost")
                {
                    ApplicationArea = all;
                }
                field("Bonding Required"; Rec."Bonding Required")
                {
                    ToolTip = 'Specifies the value of the Bonding Required field.';
                    ApplicationArea = All;
                }
                field("Bonding Period"; Rec."Bonding Period")
                {
                    ToolTip = 'Specifies the value of the Bonding Period field.';
                    ApplicationArea = All;
                }
                field("Date From";Rec."Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To";Rec."Date To")
                {

                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                    ApplicationArea = All;
                }
                field("Certificate Issued"; Rec."Certificate Issued")
                {
                    ToolTip = 'Specifies the value of the Certificate Issued field.';
                    ApplicationArea = All;
                }
                field(Objectives; Rec.Objectives)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                
                
                
               
                
                
                
                
            }
        }
    }


    actions
    {
        area(Processing)
        {

        }
    }
    var



}

