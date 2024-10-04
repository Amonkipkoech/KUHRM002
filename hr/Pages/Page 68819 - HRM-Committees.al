page 68819 "HRM-Committees"
{
    PageType = List;
    SourceTable = "HRM-Committees (B)";

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
                field(Roles; Rec.Roles)
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
                    Image = Loaners;
                    Promoted = true;
                    RunObject = Page "HRM-Commitee Members";
                    RunPageLink = Committee = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }
}

