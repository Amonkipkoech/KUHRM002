page 50097 "HRM-Provident Beneficiaries"
{
    Caption = 'Provident  Beneficiaries';
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

                field(Name; Rec.Name)
                {
                    Caption = 'Nominated Beneficiaries Names';
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Caption = 'Date of Birth of the Nominated Beneficiary';
                    ApplicationArea = all;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    Caption = 'Phone No. of the Nominated Beneficiary';
                    ApplicationArea = all;
                }
                field(Relationship; Rec.Relationship)
                {
                    Caption = 'Relationship to Principal ';
                    ApplicationArea = all;
                }
                field("Percentage(%)"; Rec."Percentage(%)")
                {
                    Caption = 'Percentage/Proportion of Benefit (Out of 100%)';
                    ApplicationArea = all;
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                    ApplicationArea = All;
                }
                field("Nominated Guardian"; Rec."Nominated Guardian")
                {
                    ToolTip = 'Specifies the value of the Nominated Guardian field.';
                    ApplicationArea = All;

                }
                field("Guardian Phone No."; Rec."Guardian Phone No.")
                {
                    Caption = 'Phone No. of the Nominated Guardian';
                    ToolTip = 'Specifies the value of the Guardian Phone No. field.';
                    ApplicationArea = All;
                }
                field("Guardian Email Address"; Rec."Guardian Email Address")
                {
                    Caption = 'E-mail address of the Nominated Guardian';
                    ToolTip = 'Specifies the value of the Guardian Email Address field.';
                    ApplicationArea = All;
                }
                field("Nominated Guardian Gender"; Rec."Nominated Guardian Gender")
                {
                    ToolTip = 'Specifies the value of the Nominated Guardian Gender field.';
                    ApplicationArea = All;
                }
                field("RelationShip of Guardian"; Rec."RelationShip of Guardian")
                {
                    caption = 'Relationship of the Nominated Guardian to Member';
                    ToolTip = 'Specifies the value of the RelationShip of Guardian field.';
                    ApplicationArea = All;
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

