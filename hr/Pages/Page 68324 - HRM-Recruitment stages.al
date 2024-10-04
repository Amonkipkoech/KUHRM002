page 68324 "HRM-Recruitment stages"
{
    PageType = ListPart;
    SourceTable = "HRM-Recruitment Stages (B)";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Recruitement Stage"; Rec."Recruitement Stage")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Failed Response Templates"; Rec."Failed Response Templates")
                {
                    ApplicationArea = All;
                }
                field("Passed Response Templates"; Rec."Passed Response Templates")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

