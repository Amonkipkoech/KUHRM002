page 69009 "HRM-Appraisal Goal Setting"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Goal Setting NY";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Planned Targets/Objectives"; Rec."Planned Targets/Objectives")
                {
                    ApplicationArea = All;
                }
                field("Success Measures"; Rec."Success Measures")
                {
                    ApplicationArea = All;
                }
                field(Timeline; Rec.Timeline)
                {
                    ApplicationArea = All;
                }
                field("Support Neede"; Rec."Support Neede")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
            }
        }
        area(processing)
        {
            action("&Next Page")
            {
                Caption = '&Next Page';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HRM-Appraisal Training Develop";
                RunPageLink = "Appraisal No" = FIELD("Appraisal No");
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //FORM.RUNMODAL(39005843
                    //PAGE.RUN(39003985,Rec);
                end;
            }
        }
    }
}

