page 69174 "HRM-Emp. Qualifications (B)"
{
    Caption = 'Academic Qualification Card';
    PageType = ListPart;
    SourceTable = "HRM-Emp. Qualifications Final";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                    Caption = 'Payroll No.';
                    Editable = false;
                }
                field("Qualification Category"; Rec."Qualification Category")
                {
                    ToolTip = 'Specifies the value of the Academics Qualification Category field.';
                    ApplicationArea = All;
                    Caption = 'Academic Qualification Category';
                }
                field("Academic Qualification"; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Academic Qualification Code field.';
                    ApplicationArea = All;
                }

                // field("Academics Qualification"; Rec."Academic Qualification")
                // {
                //     ToolTip = 'Specifies the value of the Academics Qualification field.';
                //     ApplicationArea = All;
                //     Caption = 'Academmic Qualification CUE Code';
                // }
                field("Academic Specialisation"; Rec."Academic Specialisation")
                {
                    ToolTip = 'Specifies the value of the Academics Qualification  field.';
                    ApplicationArea = All;
                }
                field("Academic Specialisation Code"; Rec."Academic Specialisation Code")
                {
                    ToolTip = 'Specifies the value of the Academics Specialisation Code field.';
                    ApplicationArea = All;
                    Caption =  'Academic Specialization CUE code';
                }
                
                field(Institution; Rec.Institution)
                {
                    ToolTip = 'Specifies the value of the Institution Attended field.';
                    ApplicationArea = All;
                    Caption = 'Institution Attended';
                
                }
                field("Year Attended From"; Rec."Year Attended From")
                {
                    ToolTip = 'Specifies the value of the Year Attended From field.';
                    ApplicationArea = All;
                }
                field("Year Attended To"; Rec."Year Attended To")
                {
                    ToolTip = 'Specifies the value of the Year Attended To field.';
                    ApplicationArea = All;
                }
               
                
                



            }
        }
    }

    actions
    {
        
    }
}

