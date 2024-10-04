page 68076 "PRL-Rates & Ceilings"
{

    PageType = Card;
    SourceTable = "PRL-Vital Setup Info";

    layout
    {
        area(content)
        {
            field("Setup Code"; Rec."Setup Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Tax Relief"; Rec."Tax Relief")
            {
                ApplicationArea = all;
            }
            field("Insurance Relief"; Rec."Insurance Relief")
            {
                ApplicationArea = all;
            }
            field("Max Relief"; Rec."Max Relief")
            {
                ApplicationArea = all;
            }
            field("NSSF Employee Factor"; Rec."NSSF Employee Factor")
            {
                ApplicationArea = all;
            }
            field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
            {
                ApplicationArea = all;
                ;
            }
            field("Apply NHIF Insurance Relief"; Rec."Apply NHIF Insurance Relief")
            {
                ToolTip = 'Specifies the value of the Apply NHIF Insurance Relief field.';
                ApplicationArea = All;
            }
            field("NHIF Based on"; Rec."NHIF Based on")
            {
                ApplicationArea = all;
                Caption = 'NHIF Based on';
            }
            field("NHIF Insurance Relief %"; Rec."NHIF Insurance Relief %")
            {
                ToolTip = 'Specifies the value of the NHIF Insurance Relief % field.';
                ApplicationArea = All;
            }
            field("NHIF Insurance Relief Limit"; Rec."NHIF Insurance Relief Limit")
            {
                ToolTip = 'Specifies the value of the NHIF Insurance Relief Limit field.';
                ApplicationArea = All;
            }
            field("Max Pension Contribution"; Rec."Max Pension Contribution")
            {
                ApplicationArea = all;
            }
            field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
            {
                ApplicationArea = all;
            }
            field("Disabled Tax Limit";Rec."Disabled Tax Limit")
            {
                ApplicationArea = all;
            }
            field("Mortgage Relief"; Rec."Mortgage Relief")
            {
                ApplicationArea = all;
                Caption = 'Less from Taxable Pay';
            }
            field("1st Overtime Based On"; Rec."1st Overtime Based On")
            {
                ApplicationArea = All;
            }
            field("1st Overtime Code"; Rec."1st Overtime Code")
            {
                ApplicationArea = All;
            }
            field("2nd Overtime Based On"; Rec."2nd Overtime Based On")
            {
                ApplicationArea = All;
            }
            field("2nd Overtime Code"; Rec."2nd Overtime Code")
            {
                ApplicationArea = All;
            }
            field("Lost Hours Based On"; Rec."Lost Hours Based On")
            {
                ApplicationArea = All;
            }
            field("Lost Hours Code"; Rec."Lost Hours Code")
            {
                ApplicationArea = All;
            }
            field("NSSF Based on"; Rec."NSSF Based on")
            {
                ApplicationArea = all;
                Caption = 'NSSF Based On';
            }
            field("Leave Allowance Based On"; Rec."Leave Allowance Based On")
            {
                ApplicationArea = all;

            }

            field("Credit Trans. Code"; Rec."Credit Trans. Code")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    var
        Text19076757: Label '(%)';
        Text19058477: Label '(Personal+Insurance)';
        Text19049626: Label '(Pension(self)+Nssf)';
        Text19080001: Label '(%)';
        Text19080002: Label '(%)';
        Text19080003: Label '(%)';
}

