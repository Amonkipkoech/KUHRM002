page 68806 "HRM-Pension Payments List"
{
    caption = 'Provident Beneficiaries';
    CardPageID = "HRM-Pension Payments";
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Pension Payments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Date Collected"; Rec."Date Collected")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = all;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = all;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = all;
                }
                field("Collected By"; Rec."Collected By")
                {
                    ApplicationArea = all;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = all;
                }
                field("Benefit Type"; Rec."Benefit Type")
                {
                    ApplicationArea = all;
                }
                field("Name of Insurance"; Rec."Name of Insurance")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Principal; Rec.Principal)
                {
                    ApplicationArea = all;
                }
                field("Principal's Names"; Rec."Principal's Names")
                {
                    ApplicationArea = all;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

