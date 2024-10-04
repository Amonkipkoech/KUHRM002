page 75023 "HRM-Appraisal Registration"
{
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Appraisal Registration";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Caption = 'Appraisal Period';
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
                    Caption = 'Reg. Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Appraisal Jobs Category"; Rec."Appraisal Jobs Category")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Trimester Activities")
            {
                Caption = 'Trimester Activities';
                Description = 'Activities in a Trimester';
                Image = LotInfo;
                action(AppraisalTargets)
                {
                    Caption = 'Appraisal Targers';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Appraisee Target";
                    RunPageLink = "PF. No." = FIELD("PF No."),
                                  "Appraisal Period Code" = FIELD("Appraisal Period Code"),
                                  "Appraisal Job Code" = FIELD("Appraisal Job Code");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Cust: Record 18;
}

