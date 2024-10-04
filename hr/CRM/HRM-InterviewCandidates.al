page 85020 "Interview Cand Mailing List"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Applications (B)";
    ModifyAllowed = false;
    SourceTableView = WHERE("Interview Status" = FILTER(Invited), Sifted = Filter(Interview));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                 field("Application No"; Rec."Application No")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Notified;Rec.Notified)
                {
                    ApplicationArea =  All;
                    Importance = Promoted;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }
                field("Job Type"; Rec."Job Type")
                {
                    ToolTip = 'Specifies the value of the Job Type field.';
                    ApplicationArea = All;
                }
            }

        }
    }


}