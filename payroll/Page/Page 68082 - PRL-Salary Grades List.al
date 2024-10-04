page 68082 "PRL-Salary Grades List"
{
    Editable = true;
    PageType = Card;
    SourceTable = "HRM-Salary Grades";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Amount"; Rec."Salary Amount")
                {
                    ApplicationArea = All;
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ApplicationArea = all;
                }
                field("Leave Allowance"; Rec."Leave Allowance")
                {
                    ApplicationArea = all;
                }
                field(Ceiling_salary; Rec.Ceiling_salary)
                {
                    ApplicationArea = all;
                }
                field(Basic_salary; Rec.Basic_salary)
                {
                    ApplicationArea = all;
                }
                field("Weekly Hours"; Rec."Weekly Hours")
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

