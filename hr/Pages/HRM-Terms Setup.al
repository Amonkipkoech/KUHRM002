page 85002 "HRM-Terms Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HRM-Terms Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Values)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                RunObject = Page "HRM-Terms Values";
                RunPageLink = "Term Code" = field(Code);
            }
        }
    }
}