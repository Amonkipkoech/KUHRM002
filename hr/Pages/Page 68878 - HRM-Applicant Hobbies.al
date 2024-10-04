page 68878 "HRM-Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HRM-Applicant Hobbies";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Hobby; Rec.Hobby)
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

