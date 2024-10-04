page 68440 "HRM-Appraisal Formats"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Formats";
    SourceTableView = SORTING("Appraisal Code", Sequence)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("In Put"; Rec."In Put")
                {
                    ApplicationArea = All;
                }
                field("Entry By"; Rec."Entry By")
                {
                    ApplicationArea = All;
                }
                field("After Entry Of Prev. Group"; Rec."After Entry Of Prev. Group")
                {
                    ApplicationArea = All;
                }
                field("Allow Previous Groups Rights"; Rec."Allow Previous Groups Rights")
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

