page 68073 "PRL-Institutional Membership"
{
    PageType = List;
    SourceTable = "PRL-Institutional Membership";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Group No"; Rec."Group No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Institution No"; Rec."Institution No")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

