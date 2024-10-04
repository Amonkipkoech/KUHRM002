page 50502 "Portal Pass"
{
    PageType = List;

    SourceTable = "HRM-Employee (D)";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(backend)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You are not allowed to work on Salaries';
    begin
        AllowAccessSettings := true;
        if usersetup.get(UserId) then
            if (usersetup."Create Salary") then begin
                AllowAccessSettings := usersetup."Create Employee";
                exit
            end;
        Error(Nopermission);
    end;

    var
        AllowAccessSettings: boolean;
}