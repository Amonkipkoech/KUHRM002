page 68072 "PRL-Membership Groups"
{
    PageType = List;
    SourceTable = "PRL-Membership Groups";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Group No"; Rec."Group No")
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
            group("Member Details")
            {
                Caption = 'Member Details';
                action("Institutional Listing")
                {
                    Caption = 'Institutional Listing';
                    RunObject = Page "PRL-Institutional Membership";
                    RunPageLink = "Group No" = FIELD("Group No");
                    ApplicationArea = All;
                }
            }
        }
    }
}

