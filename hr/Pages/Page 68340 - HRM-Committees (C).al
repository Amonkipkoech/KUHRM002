page 68340 "HRM-Committees (C)"
{
    PageType = Worksheet;
    SourceTable = "HRM-Committees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    Caption = 'Members';
                    RunObject = Page "HRM-Committee Board Of Direc.";
                    RunPageLink = Committee = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }
}

