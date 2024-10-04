page 68075 "PRL-Transaction Code"
{
    PageType = Card;
    SourceTable = "PRL-Transaction Codes";
    Caption = 'Transaction Codes';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = all;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = all;
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = all;
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = all;
                }
                field("Is Formula"; Rec."Is Formula")
                {
                    ApplicationArea = all;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = all;
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = all;
                }
                field("External Deduction"; Rec."External Deduction")
                {
                    ApplicationArea = All;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field(formulae; 'E.g. ([0.05]+[0.20]*[24])/2268....')
                {
                    ApplicationArea = all;
                    Caption = 'Formula example';
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = all;
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = all;
                }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                    ApplicationArea = all;
                }
                field(AccountName; Rec.AccountName)
                {
                    ApplicationArea = ALL;
                }
                field(ReceivingBank; Rec.ReceivingBank)
                {
                    ApplicationArea = all;
                }
                field(RecevingBranch; Rec.RecevingBranch)
                {
                    ApplicationArea = ALL;
                }
                field(AccountNo; Rec.AccountNo)
                {
                    ApplicationArea = ALL;
                }
                field(EMPfORMULA; 'E.g. ([0.05]+[0.20]*[24])/2268....')
                {
                    ApplicationArea = all;
                    Caption = 'Employer Formula Example';
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = all;
                }
                field("GL Employee Account"; Rec."GL Employee Account")
                {
                    ApplicationArea = all;
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = all;
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = all;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = all;
                    Caption = 'Interest Rate (%)';
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = all;
                }
                field("Affects Overtime"; Rec."Affects Overtime")
                {
                    ApplicationArea = all;
                }
                field("Affects Lost Hours"; Rec."Affects Lost Hours")
                {
                    ApplicationArea = all;
                }
                field("Calculate from Days"; Rec."Calculate from Days")
                {
                    ToolTip = 'Specifies the value of the Calculate from Days field.';
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
    }

    var
        Text19065628: Label 'Transaction Type';
        Text19046900: Label 'Balance Type';
        Text19025872: Label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: Label 'E.g ([005]+[020]*[24])/2268';
        Text19015031: Label '%';
}

