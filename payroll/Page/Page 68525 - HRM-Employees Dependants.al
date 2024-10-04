page 68525 "HRM-Employees Dependants"
{
    Caption = 'Employee Dependants';
    PageType = List;
    SourceTable = "HRM-Employee Kin";
    SourceTableView = WHERE(Type = FILTER(Dependant));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                
              
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
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee Code"),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Dependant;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Dependant;
    end;

    var
        D: Date;
}

