page 85609 "HRM-Responsibility"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Responsibility Contact';
    PageType = List;
    SourceTable = "HRM-Employee Responsibility";
    layout
    {
        area(Content)
        {
            repeater(Control1000000000)
            {
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }

            }

        }
    }
}