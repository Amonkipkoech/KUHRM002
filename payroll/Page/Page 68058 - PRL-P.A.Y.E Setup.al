page 68058 "PRL-P.A.Y.E Setup"
{
    Editable = true;
    PageType = Card;
    SourceTable = "PRL-PAYE";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = all;
                }
                field("PAYE Tier"; Rec."PAYE Tier")
                {
                    ApplicationArea = all;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You are not allowed to work on Salaries';
        AllowAccessSettings: boolean;
    begin
        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Create Salary") then begin
                AllowAccessSettings := usersetup."Create Salary";
                exit
            end;
        Error(Nopermission);
    end;
}

