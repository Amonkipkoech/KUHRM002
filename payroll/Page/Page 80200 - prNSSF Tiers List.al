page 80200 "prNSSF Tiers List"
{

    ApplicationArea = All;
    Caption = 'prNSSF Tiers List';
    PageType = List;
    SourceTable = "prNSSF Tiers";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Tier; Rec.Tier)
                {
                    ApplicationArea = All;
                }

                field("Tier 1 Employee Deduction"; Rec."Tier 1 Employee Deduction")
                {
                    ApplicationArea = All;
                }
                field("Tier 1 Employer Contribution"; Rec."Tier 1 Employer Contribution")
                {
                    ApplicationArea = All;
                }

                field("Tier 2 Employee Deduction"; Rec."Tier 2 Employee Deduction")
                {
                    ApplicationArea = All;
                }
                field("Tier 2 Employer Contribution"; Rec."Tier 2 Employer Contribution")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
