page 68434 "HRM-Employment History (B)"
{
    PageType = Document;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group(Genera)
            {
                Caption = 'General';
                Editable = false;
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }

                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;
                }
                field("Salary Category"; Rec."Salary Category")
                {
                    ApplicationArea = All;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    TableRelation = "HRM-Auto Inreament Sal. Steps"."Stage Code" WHERE("Employee Category" = FIELD("Salary Category"));
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                    ApplicationArea = All;
                }
                field(Steps; Rec.Steps)
                {
                    Caption = 'Salary Step';
                    TableRelation = "HRM-Auto Inreament Sal. Steps"."Stage Code" WHERE("Salary Grade" = FIELD("Salary Grade"));
                    ApplicationArea = All;
                }

            }
            part(KPA; "HRM-Emp. History Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Employee No." = FIELD("No.");
            }
            field(Control1000000030; '')
            {
                CaptionClass = Text19034996;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        KPAObjectives: Record "HRM-KPA Objectives (B)";
        KPACode: Code[20];
        Text19034996: Label 'Employment History';
}

