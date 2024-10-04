page 75029 "HRM-Appraisal Reg List 2"
{
    Editable = false;
    PageType = List;
    SourceTable = 75007;

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Caption = 'Reg. Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("PF No."; Rec."PF No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    Caption = 'Appraisal Job Code';
                    ApplicationArea = All;
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Appraisal Jobs Category"; Rec."Appraisal Jobs Category")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Cust: Record 18;
}

