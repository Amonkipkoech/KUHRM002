page 68803 "HRM-Emp. Beneficiaries List"
{
    Caption = 'Employee Beneficiaries';
    CardPageID = "HRM-Employee Beneficiaries";
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                }
                field("Marital Status"; Rec."Marital Status")
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

