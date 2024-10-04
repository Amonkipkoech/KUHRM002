page 68061 "PRL-List TransCode"
{
    CardPageID = "PRL-Transaction Code";
    PageType = List;
    SourceTable = "PRL-Transaction Codes";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Enabled = true;
                ShowCaption = false;
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                {
                    ApplicationArea = all;
                }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Is Formula"; Rec."Is Formula")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = all;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = all;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(View)
            {
                Caption = 'View';
                action("SetUp Card")
                {
                    Caption = 'SetUp Card';
                    RunObject = Page "PRL-Transaction Code";
                    RunPageLink = "Transaction Code" = FIELD("Transaction Code");
                    RunPageView = SORTING("Transaction Code");
                    ApplicationArea = All;
                }
            }
        }
    }
}

