page 68090 "PRL-Short Listing Lines"
{
    AutoSplitKey = false;
    PageType = ListPart;
    SourceTable = "HRM-Shortlisting creteria";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field(Requirements; Rec.Requirements)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    Caption = 'Desired Score';
                    ApplicationArea = All;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

