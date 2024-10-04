page 85560 "HRM Minimum Job Requirements"
{
    PageType = ListPart;
    SourceTable = "HRM-Minimun Job Requirements";
    SourceTableView = sorting(entry);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Entry; Rec.Entry)
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Minimum Requirements"; Rec."Minimum Requirements")
                {
                    ApplicationArea = ALL;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}