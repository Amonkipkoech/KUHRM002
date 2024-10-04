page 75058 "HRM-Intern&Attach Card"

{
    PageType = Card;
    SourceTable = "HRM-Internships&Attachments";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = All;
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field(Renewable; Rec.Renewable)
                {
                    ApplicationArea = All;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = All;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                label("-----------Duties Performed---------------------------")
                {
                    Caption = '-----------Duties Performed---------------------------';
                    ApplicationArea = All;
                }
                field("Role 1"; Rec."Role 1")
                {
                    ApplicationArea = All;
                }
                field("Role 2"; Rec."Role 2")
                {
                    ApplicationArea = All;
                }
                field("Role 3"; Rec."Role 3")
                {
                    ApplicationArea = All;
                }
                field("Role 4"; Rec."Role 4")
                {
                    ApplicationArea = All;
                }
                field("Role 5"; Rec."Role 5")
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
