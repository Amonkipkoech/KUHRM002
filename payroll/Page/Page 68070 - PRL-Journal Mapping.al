page 68070 "PRL-Journal Mapping"
{
    PageType = Card;
    SourceTable = "PRL-Journal Trans Mapping";

    layout
    {
        area(content)
        {
            field("Transaction Code"; Rec."Transaction Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("GL Navision"; Rec."GL Navision")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("GL Others"; Rec."GL Others")
            {
                Caption = 'GL (Other FMS)';
                ApplicationArea = All;
            }
            field("Append StaffCode"; Rec."Append StaffCode")
            {
                ApplicationArea = All;
            }
            field("Amount (Dr/Cr)"; Rec."Amount (Dr/Cr)")
            {
                ApplicationArea = All;
            }
            field(Analysis0; Rec.Analysis0)
            {
                Caption = 'Analysis 0';
                ApplicationArea = All;
            }
            field(Analysis1; Rec.Analysis1)
            {
                Caption = 'Analysis 1';
                ApplicationArea = All;
            }
            field(Analysis2; Rec.Analysis2)
            {
                Caption = 'Analysis 2';
                ApplicationArea = All;
            }
            field(Analysis3; Rec.Analysis3)
            {
                Caption = 'Analysis 3';
                ApplicationArea = All;
            }
            field(Analysis4; Rec.Analysis4)
            {
                Caption = 'Analysis 4';
                ApplicationArea = All;
            }
            field(Analysis5; Rec.Analysis5)
            {
                Caption = 'Analysis 5';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

