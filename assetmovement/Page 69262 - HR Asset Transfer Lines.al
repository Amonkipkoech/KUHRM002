page 70028 "HR Asset Transfer Lines"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                }
                field("Asset Bar Code"; Rec."Asset Bar Code")
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                }
                field("FA Location"; Rec."FA Location")
                {
                    ApplicationArea = All;
                }
                field("Asset Serial No"; Rec."Asset Serial No")
                {
                    ApplicationArea = All;
                }
                field("Book Value"; Rec."Book Value")
                {
                    ApplicationArea = All;
                }
                field("Responsible Employee Code"; Rec."Responsible Employee Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("New Responsible Employee Code"; Rec."New Responsible Employee Code")
                {
                    Caption = 'Responsible Employee';
                    ApplicationArea = All;
                }
                field("New Employee Name"; Rec."New Employee Name")
                {
                    Caption = 'Employee Name';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Current Regional Office';
                    ApplicationArea = All;
                }
                field("New Global Dimension 1 Code"; Rec."New Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = ' <Current Project Code>';
                    ApplicationArea = All;
                }
                field("New Global Dimension 2 Code"; Rec."New Global Dimension 2 Code")
                {
                    Caption = '<New Project Code>';
                    ApplicationArea = All;
                }
                field("New  Dimension 2 Name"; Rec."New  Dimension 2 Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("New Global Dimension 3 Code"; Rec."New Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("New  Dimension 3 Name"; Rec."New  Dimension 3 Name")
                {
                    ApplicationArea = All;
                }
                field("Is Asset Expected Back?"; Rec."Is Asset Expected Back?")
                {
                    ApplicationArea = All;
                }
                field("New Asset Location"; Rec."New Asset Location")
                {
                    ApplicationArea = All;
                }
                field("Reason for Transfer"; Rec."Reason for Transfer")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Transfer)
            {
                Image = TaskPage;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
            }
        }
    }
}

