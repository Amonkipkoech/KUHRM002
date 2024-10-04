page 68733 "HRM-Employee Beneficiaries"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = all;
                    Caption = 'Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = TRUE;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = TRUE;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = TRUE;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
            }
            part(Control1102755008; "HRM-Provident Beneficiaries")
            {
                ApplicationArea = all;
                SubPageLink = "Employee Code" = FIELD("No."),
                              Type = CONST(Beneficiary);
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; MyNotes)
            {
                ApplicationArea = all;
                //todo  SubPageLink = "Employee Code" = FIELD("No.");
            }
            systempart(Control1102755002; Outlook)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    var
        D: Date;
        EmpNames: Text[30];
        HREmp: Record "HRM-Short Listed Applicant";
        Text19032351: Label 'Next Of Kin/Beneficiaries';
}

