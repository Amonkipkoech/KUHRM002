page 68922 "HRM-Commitee Membership"
{
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Commitee Members (KNCHR)";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Committee; Rec.Committee)
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

