page 75057 "HRM-Intern&Attach List"

{
    CardPageID = "HRM-Intern&Attach Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Internships&Attachments";

    layout
    {
        area(content)
        {
            repeater(Group)
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
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Attachment Letter")
            {
                ApplicationArea = All;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Report "HRM-Internships&Attachments";
                trigger OnAction()
                var
                    refcode: Record "HRM-Internships&Attachments";
                begin
                    refcode.Reset;
                    refcode.SetRange(refcode."Ref No", Rec."Ref No");
                    if refcode.Find('-') then
                        REPORT.Run(51723, true, false, refcode);

                end;
            }
            action("Memo Letter")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                // RunObject = Report "HRM-Internships Memo";

                trigger OnAction()
                var
                    refcode: Record "HRM-Internships&Attachments";
                begin
                    refcode.Reset;
                    refcode.SetRange(refcode."Ref No", Rec."Ref No");
                    if refcode.Find('-') then
                        REPORT.Run(51724, true, false, refcode);

                end;
            }
           /* action("Internship Letter")
            {
                Image = CashFlow;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                //  RunObject = Report "HRM-Internships";
                trigger OnAction()
                var
                    refcode: Record "HRM-Internships&Attachments";
                begin
                    refcode.Reset;
                    refcode.SetRange(refcode."Ref No", Rec."Ref No");
                    if refcode.Find('-') then
                        REPORT.Run(51725, true, false, refcode);

                end;
            }*/
            action("Recommendation Letter")
            {
                Image = RollUpCosts;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                // RunObject = Report "HRM-Recommendation";

                trigger OnAction()
                var
                    refcode: Record "HRM-Internships&Attachments";
                begin
                    refcode.Reset;
                    refcode.SetRange(refcode."Ref No", Rec."Ref No");
                    if refcode.Find('-') then
                        REPORT.Run(51726, true, false, refcode);

                end;
            }
        }
    }
}
