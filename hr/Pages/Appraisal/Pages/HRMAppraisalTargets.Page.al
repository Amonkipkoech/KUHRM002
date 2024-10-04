page 75019 "HRM-Appraisal Targets"
{
    PageType = List;
    SourceTable = 75004;

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    Caption = 'CF';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        UnitsSubj: Record 75004;
}

