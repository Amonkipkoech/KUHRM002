page 69103 "HRM-Salary Grades List"
{
    CardPageID = "HRM-Salary Grades Card";
    PageType = List;
    SourceTable = "HRM-Salary Grade Listing";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
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

