page 68135 "PRL-Transactions Codes List"
{
    CardPageID = "PRL-Transaction Code";
    PageType = List;
    SourceTable = "PRL-Transaction Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = All;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = All;
                }
                field("Is Formula"; Rec."Is Formula")
                {
                    ApplicationArea = All;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = All;
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = All;
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = All;
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                    ApplicationArea = All;
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = All;
                }
                field(isHouseAllowance; Rec.isHouseAllowance)
                {
                    ApplicationArea = All;
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = All;
                }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code old"; Rec."Transaction Code old")
                {
                    ApplicationArea = All;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = All;
                }
                field("GL Employee Account"; Rec."GL Employee Account")
                {
                    ApplicationArea = All;
                }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = All;
                }
                field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                {
                    ApplicationArea = All;
                }
                field("Deduct Mortgage"; Rec."Deduct Mortgage")
                {
                    ApplicationArea = All;
                }
                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = All;
                }
                field(Welfare; Rec.Welfare)
                {
                    ApplicationArea = All;
                }
                field(CustomerPostingGroup; Rec.CustomerPostingGroup)
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

