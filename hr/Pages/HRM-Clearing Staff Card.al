page 70096 "HRM-Clearing Staff Card"
{
    Caption = 'Clearing Staff Card';
    ModifyAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Clearance Teamplate';
    PageType = Card;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Payroll Number field.';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies Date Of Join';
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ToolTip = 'Specifies the value of the Employee Category field.';
                    ApplicationArea = All;
                }
                field(DService; DService)
                {
                    ApplicationArea = all;
                    Caption = 'Length of Service';
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clearance Template")
            {

                Visible = false;

                ApplicationArea = All;
                Caption = 'Clearance Template';
                Promoted = true;
                Image = Template;
                PromotedCategory = Category4;
                RunObject = Page "HRM Clearance Template";
                RunPageLink = "Employee No." = field("No.");



            }
        }
    }
    trigger OnAfterGetRecord()
    begin

        DService := '';




        //Recalculate Important Dates
        if (Rec."Date Of Leaving" = 0D) then begin

            if (Rec."Appointment Date" <> 0D) then
                DService := Dates.DetermineAge(Rec."Appointment Date", Today);

            //MODIFY;
        end else begin

            if (Rec."Appointment Date" <> 0D) then
                DService := Dates.DetermineAge(Rec."Appointment Date", Today);

            //MODIFY;
        end;
    end;

    var
        myInt: Integer;
        DService: Text[100];
        Dates: Codeunit "HR Dates";
}