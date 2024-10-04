page 68409 "HRM-Over Staffed Positions"
{
    Editable = false;
    PageType = Card;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = All;
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.Reset;
        if Rec.Find('-') then begin
            repeat
                Rec.CalcFields("Occupied Position");
                // MESSAGE('%1',"Occupied Position");
                Rec."Vacant Posistions" := Rec."No of Posts" - Rec."Occupied Position";
                Rec.Modify;
            until Rec.Next = 0;
        end;
        Rec.Reset;
        Rec.SetCurrentKey("Vacant Posistions");
        Rec.SetFilter("Vacant Posistions", '<%1', 0);
    end;
}

