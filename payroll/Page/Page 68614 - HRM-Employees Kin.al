page 68614 "HRM-Employees Kin"
{
    Caption = 'Employee Next Of  Kin';
    PageType = List;
    SourceTable = "HRM-Employee Kin";
    SourceTableView = WHERE(Type = FILTER("Next of Kin"));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
               
                                
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ApplicationArea = All;
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                    ToolTip = 'Specifies the value of the Alternate Phone No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
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

    var
        D: Date;
}

