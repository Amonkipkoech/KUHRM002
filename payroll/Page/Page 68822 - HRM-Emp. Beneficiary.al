page 68822 "HRM-Emp. Beneficiary"
{
    Caption = 'Employee  Beneficiaries';
    PageType = ListPart;
    SourceTable = "HRM-Employee Kin";
    SourceTableView = WHERE(Type = FILTER(Beneficiary));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = all;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = all;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = all;
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    ApplicationArea = all;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = all;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                    ApplicationArea = all;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    ApplicationArea = all;
                }
                field("Percentage(%)"; Rec."Percentage(%)")
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee Code"),
                                  "Table Line No." = FIELD("Line No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Beneficiary;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Beneficiary;
    end;

    var
        D: Date;
}

