page 75027 "HRM-Appraisal Supervisors"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = 61188;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'Employee No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Department Allocations")
            {
                Caption = 'Department Allocations';
                part(Dept; 75028)
                {
                    Caption = 'Department Setup';
                    SubPageLink = "HOD" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Lecturer := TRUE;
    end;

    var
        KPAObjectives: Record 61293;
        KPACode: Code[20];
        LecUnits: Record 75019;
        Vend: Record 23;
        gnLine: Record 81;
        GeneralSetup: Record 75008;
        GL: Record 17;
}

